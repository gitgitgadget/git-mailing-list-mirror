From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git am and mangled subject lines
Date: Mon, 24 Feb 2014 12:38:29 -0800
Message-ID: <20140224203829.GJ7855@google.com>
References: <530B9D50.6020705@ubuntu.com>
 <xmqqios48drt.fsf@gitster.dls.corp.google.com>
 <530BAA6F.4030401@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 21:38:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI2Ie-0002Fy-KW
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 21:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183AbaBXUie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 15:38:34 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:39065 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbaBXUid (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 15:38:33 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so7049310pbc.10
        for <git@vger.kernel.org>; Mon, 24 Feb 2014 12:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=j7pAcOPOT+xidLRLOX2uDggHLZIWNq4fsY1CuBPlpwQ=;
        b=yRkGcLdza6xEz81XdBylKjmmCROM2B8/x3MzHQsCAZ78zewG8ZieE0Rcl+TOhJSxOu
         6yFUg0nEZyYfxCZZos3sJmtyXhFMMA5tT10SIXaTTLNLJYOjAGI4OzJw8j0vIikKUylc
         yeG9ckmro3ha0pKarmtSDGobt8fX4lUzbqCSD+7fxhRz1dWEWLrItdkm0U1KHBI7XPK0
         QWGk8CyLR7vsMVodajQFNQy4govDodtWM2MDH6FnDk/8SUNyyYXl9RzyofO0kfApGsBu
         CEmB75lXm0qUZqVs8kHhPiGuH9IZimhedjVVHQtImwRHxTjw8hj9+dovqAxlfnTWHXre
         1rEw==
X-Received: by 10.66.163.164 with SMTP id yj4mr27260178pab.91.1393274312768;
        Mon, 24 Feb 2014 12:38:32 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ug2sm126871312pac.21.2014.02.24.12.38.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 24 Feb 2014 12:38:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <530BAA6F.4030401@ubuntu.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242644>

Hi,

Phillip Susi wrote:
> On 2/24/2014 3:19 PM, Junio C Hamano wrote:
>> Phillip Susi <psusi@ubuntu.com> writes:

>>> git am already ignores the "[PATCH X/Y]" prefix that
>>> format-patch adds.  Is it possible to get it to ignore any
>>> additional prefix that a bug tracker mangles into the subject
>>> line?  i.e. "bug #nnnn:"?
>>
>> I think applypatch-msg hook is your friend in a case like this.
>
> Can you point me in the direction of some documentation on this?  I
> don't see it mentioned in the man pages for git am or mailinfo ( I
> would think that would be the place to have it ).

Gladly.

Thanks for noticing.

-- >8 --
Subject: am doc: add a pointer to relevant hooks

It is not obvious when looking at a new command what hooks will affect
it.  Add a HOOKS section to the git-am(1) page, imitating
git-commit(1), to make it easier for people to discover e.g. the
applypatch-msg hook that can implement a custom subject-mangling
strategy (e.g., removing a "bug #nnnn:" prefix introduced by a bug
tracker).

Reported-by: Phillip Susi <psusi@ubuntu.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-am.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 54d8461..abcffb6 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -189,6 +189,11 @@ commits, like running 'git am' on the wrong branch or an error in the
 commits that is more easily fixed by changing the mailbox (e.g.
 errors in the "From:" lines).
 
+HOOKS
+-----
+This command can run `applypatch-msg`, `pre-applypatch`,
+and `post-applypatch` hooks.  See linkgit:githooks[5] for more
+information.
 
 SEE ALSO
 --------
-- 
1.9.0.rc1.175.g0b1dcb5
