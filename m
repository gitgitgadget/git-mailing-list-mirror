From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v5 12/44] builtin-am: implement --skip
Date: Tue, 14 Jul 2015 17:34:23 +0800
Message-ID: <CACRoPnRri5Nu5rj9O7id+PyiDBJpZkBDk8kB0WCuB3Uef76M3g@mail.gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
	<1436278862-2638-13-git-send-email-pyokagan@gmail.com>
	<CAGZ79kaWV-hMEgJ8HJP2Jgq78su+YbyBbcYD3sZ0474UUNw=pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 11:34:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEwbd-0003sw-IW
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 11:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbbGNJeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 05:34:25 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36066 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbbGNJeY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 05:34:24 -0400
Received: by lbbpo10 with SMTP id po10so2630986lbb.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 02:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HCl8/4CjP7TrjuMHOuEhWpzwLpUmUxGgnwvCgAN0IV8=;
        b=qTu5DxUZOvIRknouvFHpbghecLoghL48N7i2aFIUM7VLYs8rkiNrPVZo+05w1BLIsL
         1qR+gh9mZ1ZnJ7nB5+Fnx/sLLKf9DZX1clTZzbwLOhJuQaktp3yJJht0HgUdCZnHY2Zj
         8Ohnn1aqRIYUBj9KWjYXWI73tFroR1BMTgyXl6+VRC9uf8C5Hw2zbhCMJBpBSk6Pa+6V
         vZJSiBSm2rIcnFWY7SjQ5zHiMfzg8j1ZFz96l347H9Cex7a4NjqAKxFjX7bYYRzl5WEg
         pyTKnIA+ZzR3T2LEST7skDlLnFZYFmasdlbtJ177kKXK2ABKCcZhoAOaU2yeeXmcFraZ
         BH5Q==
X-Received: by 10.152.4.163 with SMTP id l3mr37266430lal.35.1436866463661;
 Tue, 14 Jul 2015 02:34:23 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 14 Jul 2015 02:34:23 -0700 (PDT)
In-Reply-To: <CAGZ79kaWV-hMEgJ8HJP2Jgq78su+YbyBbcYD3sZ0474UUNw=pA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273943>

On Tue, Jul 14, 2015 at 3:05 AM, Stefan Beller <sbeller@google.com> wrote:
> All returns before this point leak the memory of `lock_file`.

Yeah, it's intentional. From Documentation/technical/api-lockfile.txt:

* Allocates a `struct lock_file` either as a static variable or on the
  heap, initialized to zeros. Once you use the structure to call the
  `hold_lock_file_*` family of functions, it belongs to the lockfile
  subsystem and its storage must remain valid throughout the life of
  the program (i.e. you cannot use an on-stack variable to hold this
  structure).

Thanks,
Paul
