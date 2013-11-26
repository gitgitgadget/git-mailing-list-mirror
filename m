From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Filter log based on paths NOT touched
Date: Tue, 26 Nov 2013 10:13:53 +0700
Message-ID: <CACsJy8DR-ckmZ8Ey9Gh1fhv17_+mRPmeLdj_7LoCnvc9fnnpTg@mail.gmail.com>
References: <5293B0F9.1050200@ubuntu.com> <xmqqeh64xlqw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phillip Susi <psusi@ubuntu.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 04:14:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl96b-0004bX-7I
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 04:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143Ab3KZDOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 22:14:25 -0500
Received: from mail-qa0-f49.google.com ([209.85.216.49]:47849 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab3KZDOY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 22:14:24 -0500
Received: by mail-qa0-f49.google.com with SMTP id ii20so7159647qab.15
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 19:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=N9rURNyYdrsCV4yuKFdjt4EjY+bTSbl1b1vpezSAT4I=;
        b=U6qBI2BTNO+p5RQLhNI8jAeYrbqU0HJdfk5q59w5b89j+wCLdh/j3Dh3YkXThZRGHL
         trIpHGIpnZ6nLeFeP6uAhWqPZlpDgcNIw0bkUtjWb6oE8OpPS9OUh21FArYrSJg2BaEK
         JkjYBc0EGzsH5KrVw+XMvaXR0MDMmdW0pGUPf8xxIG+4dECQ42bq9WYywEdlhPPCUIKe
         TQkldIqnsABguzCocNW8Gt3rSpwNzRR7CGaZFY2HE+VWhkky7m2K9FaK5bpZ03Bid6oI
         c2iTRXwOoB+2NsJg3sTSp/Se1kPfjARnwxVkeYrrV6aSpgLbbbrCSUGtbwQSU1fDMAw4
         ZOxw==
X-Received: by 10.224.51.7 with SMTP id b7mr52203089qag.74.1385435664127; Mon,
 25 Nov 2013 19:14:24 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Mon, 25 Nov 2013 19:13:53 -0800 (PST)
In-Reply-To: <xmqqeh64xlqw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238369>

On Tue, Nov 26, 2013 at 3:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Phillip Susi <psusi@ubuntu.com> writes:
>
>> I can't seem to find a way to invert the meaning of a pathspec given
>> to git log in order to find commits touching anything BUT a given
>> path.  Does such a thing exist?
>
> Not yet (look for "negative pathspec").

There's a difference between "skip commits that touch anything
directory foo even if it also touches something outside of foo" and
"skip commits that _only_ touches something in foo". Not sure which
way Phillip wants here. Negative pathspec only supports the latter.
The former needs a new option in rev-list, because the logic to
consider a commit not a match if it matches a pathspec is out of
tree_entry_interesting()'s control.
-- 
Duy
