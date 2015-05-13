From: Paul Tan <pyokagan@gmail.com>
Subject: Re: git-pull --tags with no merge candidates case gives confusing
 error message
Date: Wed, 13 May 2015 18:13:51 +0800
Message-ID: <CACRoPnSjaE677xa9i2m-f28TYbfg7XbmWOP9r_-5ELhXOWY2fQ@mail.gmail.com>
References: <CACRoPnQvNvBv1_wBzWQH6A8XRvWZ+HURvtkqtgYpwjjNXuCERg@mail.gmail.com>
	<555259E5.4040304@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 13 12:14:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsTfq-0003WC-RI
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 12:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933456AbbEMKNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 06:13:54 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:34908 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932204AbbEMKNx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 06:13:53 -0400
Received: by labbd9 with SMTP id bd9so25667151lab.2
        for <git@vger.kernel.org>; Wed, 13 May 2015 03:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MNAOvBWqfQTtf/5qhsnmikFj5qu7ECiTJIqPNqZpHwI=;
        b=FADOMFK/0XOAUzdnzW+OzbM8uiolb1HcCYRc26sM1E7xRvye5O3jV0R26fa3//D+um
         O0F/VfiaHhbfGP9ke0jqiG5z7LMe+gIG1rbdlvvdFPhLNSHvbD0goZzEoZiOHlaMYeoo
         m8QKDhT+y3xASHE2XKwa5Cc2kH/9kX8Lanv9S4Z9yG+GnFOFUqbs16CccO/pAH425l6I
         CK3Vm3qHhUJ4v6D3vkxGi4mMJzjSUNocCKzhUjXA3z5yAHgErzrBuf7hbfJNItt/+ntz
         7BpPfogNG4dPW3YKXPzQ8kgFNA709GU8e24OvnYR67yNbFuQjPKsFzY1PI87gOz3B9CF
         8adA==
X-Received: by 10.152.18.194 with SMTP id y2mr2571782lad.74.1431512031723;
 Wed, 13 May 2015 03:13:51 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Wed, 13 May 2015 03:13:51 -0700 (PDT)
In-Reply-To: <555259E5.4040304@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268977>

Hi,

On Wed, May 13, 2015 at 3:52 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> I never use pull so I'm not really acquainted with its semantics. But it
> seems to me that when you remove the special "--tags" error message, you
> might also have to adjust the logic later in the function that looks at
> "$#". Specifically, unless the presence of a "--tags" option can provide
> candidates for merging, then in "[ $# -gt 1 ]", "$#" might need to be
> changed to "the number of arguments *not including --tags arguments*".

Yes, I'm aware of the problems of using "$@" and "$#" including
git-fetch's options in git-pull[1]. It's not just enough to skip over
arguments that look like options, though, as we do not know if the
options take values or not, so the whole logic may become complicated.
I'm planning to solve it in a later patch series by explicitly parsing
git-fetch's options as well.

[1] http://thread.gmane.org/gmane.comp.version-control.git/268510/focus=268565

Thanks,
Paul
