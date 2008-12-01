From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] gitweb: patch view
Date: Mon, 1 Dec 2008 01:45:34 +0100
Message-ID: <200812010145.36612.jnareb@gmail.com>
References: <1227966071-11104-1-git-send-email-giuseppe.bilotta@gmail.com> <200811300206.23240.jnareb@gmail.com> <cb7bb73a0811291744t2bb9c8c1t1dac497705e2c3c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 01:46:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6wwD-00083q-K1
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 01:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756854AbYLAApm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 19:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756561AbYLAApm
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 19:45:42 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:1446 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756855AbYLAApl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 19:45:41 -0500
Received: by ey-out-2122.google.com with SMTP id 6so940302eyi.37
        for <git@vger.kernel.org>; Sun, 30 Nov 2008 16:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GLgYss7Ti1W7oPGMiNnOYvHq7eSdvXToNEOk1Ky8T84=;
        b=R3wQSulFz+gz5uSiGjvJ6llhJaxd/2Ds677FOtE9DVUTd62PEa7DauMSmHB0CWYw/6
         iB3f3CCnYOdfwIKUVi1JCxOWyUdd4a2qwaXCj1eNwFB+ROB3Xt+PkxtFSgTOGkK3Wkk8
         Vzcb+Ncw8dFBQ5aDuP+g1CLznKYSOJPsN+Flo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kI/79bm227Gi0FAOl/6Wdk8o9rjgxI4A/OPbfq5TaJ9CcrV5Dz4XXd0XTUDT8zXmFj
         6U+70EbkNCtb+niJeKoKdtrLX1WrlJByXWKA+C+SWAAps0GngeaMXLtHVRAp6kJFy5Vs
         +H/zGoCuzwPoqLcfjgN6VOlMdC7LXnOhbuw8U=
Received: by 10.210.19.11 with SMTP id 11mr6661822ebs.34.1228092338900;
        Sun, 30 Nov 2008 16:45:38 -0800 (PST)
Received: from ?192.168.1.11? (abwt156.neoplus.adsl.tpnet.pl [83.8.243.156])
        by mx.google.com with ESMTPS id 5sm5677563eyf.40.2008.11.30.16.45.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Nov 2008 16:45:37 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0811291744t2bb9c8c1t1dac497705e2c3c2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101995>

On Sun, 30 Nov 2008, Giuseppe Bilotta wrote:
> On Sun, Nov 30, 2008 at 2:06 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Sat, 29 Nov 2008, Giuseppe Bilotta wrote:
>>
>>> I recently discovered that the commitdiff_plain view is not exactly
>>> something that can be used by git am directly (for example, the subject
>>> line gets duplicated in the commit message body after using git am).
>>
>> That's because gitweb generates email-like format "by hand", instead
>> of using '--format=email' or git-format-patch like in your series. On
>> the other hand that allows us to add extra headers, namely X-Git-Tag:
>> (which hasn't best implementation, anyway) and X-Git-Url: with URL
>> for given output.
> 
>> By the way, we still might want to add somehow X-Git-Url and X-Git-Tag
>> headers later to 'patch' ('patchset') output format.
> 
> Yeah, I've been thinking about it, but I couldn't find an easy and
> robust way to do it. Plus, should we add them for each patch, or just
> once for the whole patchset?

True, that is a complication. Perhaps they should be added only for
single patch?

>>> Since I'm not sure if it was the case to fix the plain view because I
>>> don't know what its intended usage was, I prepared a new view,
>>> uncreatively called 'patch', that exposes git format-patch output
>>> directly.
>>
>> Perhaps 'format_patch' would be better... hmmm... ?
> 
> Considering I think commitdiff is ugly and long, you can guess my
> opinion on format_patch 8-P. 'patchset' might be a good candidate,
> considering it's what it does when both hash_parent and hash are
> given.

True, 'patchset' might be even better, especially that it hints
what it does for a range a..b (not diff of endpoints, but series
of patches).

>> Actually IMHO both 'commitdiff' and 'commitdiff_plain' try to do two
>> things at once. First to show diff _for_ a commit, i.e. equivalent of
>> "git show" or "git show --pretty=email", perhaps choosing one of
>> parents for a merge commit. Then showing commit message for $hash has
>> sense. The fact that 'commit' view doesn't show patchset, while
>> 'commitdiff' does might be result of historical situation.
>>
>> Second, to show diff _between_ commits, i.e. equivalent of
>> "git diff branch master". Then there doesn't make much sense to show
>> full commit message _only_ for one side of diff. IMHO that should be
>> main purpose of 'commitdiff' and 'commitdiff_plain' views, or simply
>> 'diff' / 'diff_plain' future views.
> 
> We can probably consider deprecating commitdiff(_plain) and have the
> following three views:
> 
> * commit(_plain): do what commitdiff(_plain) currently does for a single commit

Equivalent of "git show" (and not merely "git cat-file -t commit").

> * diff(_plain): do what commitdiff(_plain) currently does for
> parent..hash views, modulo something to be discussed for commit
> messages (a shortlog rather maybe?)

Equivalent of "git diff" (or "git diff-tree").

Diffstat, or dirstat might be a good idea. Shortlog... I am not sure.
Diff is about endpoints, and they can be in reverse, too.

There is a problem how to denote endpoints.

> * patch[set?][_plain?]: format-patch style output (maybe with option
> for HTML stuff too)

Equivalent of "git format-patch".

Actually the HTML format would be more like "git log -p", so perhaps
that could be handled simply as a version of 'log' view (perhaps via
@extra_options aka 'opt' parameter).

>> What 'patch' view does, what might be not obvious from this description
>> and from first patch in series, is to show diffs for _series_ of
>> commits. It means equivalent of "git log -p" or "git whatchanged".
>> It might make more sense to have plain git-format-patch output, but it
>> could be useful to have some kind of 'git log -p' HTML output.
>>
>> So even if 'commitdiff' / 'commitdiff_plain' is fixed, 'patch' whould
>> still have its place.
> 
> Nice to know. Do consider the current version more of a
> proof-of-concept that some definitive code.

Ah. O.K. It would be nice if this patch was marked as RFC (well, lack
of signoff hints at this), or as WIP, or as PoC,...

>>> The second patch exposes it from commitdiff view (obviosly), but also
>>> from shortlog view, when less than 16 patches are begin shown.
>>
>> Why this nonconfigurable limit?
> 
> Because the patch was actually a quick hack for the proof of concept
> 8-) I wasn't even sure the patch idea would have been worth it (as
> opposed to email-izing commitdiff_plain).

Ah.

Well, we might want to impose some limit to avoid generating and sending
patchset for a whole history. Perhaps to page size (100), or some similar
number?
-- 
Jakub Narebski
Poland
