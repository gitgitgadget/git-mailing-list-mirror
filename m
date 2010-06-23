From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: potential improvement to 'git log' with a range
Date: Wed, 23 Jun 2010 20:02:17 +0200
Message-ID: <201006232002.18921.jnareb@gmail.com>
References: <w2j3abd05a91004091624mb2836ff4v118a1ae9ac5ca6e7@mail.gmail.com> <m3tyrhfzg8.fsf@localhost.localdomain> <87bpb1issa.fsf@hbox.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	mercurial list <mercurial-devel@selenic.com>,
	git list <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Aghiles <aghilesk@gmail.com>
To: Martin Geisler <mg@lazybytes.net>
X-From: git-owner@vger.kernel.org Wed Jun 23 20:02:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORUHU-0003Xx-Jv
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 20:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708Ab0FWSCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 14:02:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:36577 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423Ab0FWSCa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 14:02:30 -0400
Received: by fg-out-1718.google.com with SMTP id l26so438243fgb.1
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 11:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=v0mVSAV+SwzREZafs/9mN+SmUw9HZBqDteOO+3Z8LOI=;
        b=lAs05cJm4vtk6nN0BMYgVYzIheZ8GQVbp9K6j5xqTTgsLx2dXb4qfuGaPrZCu/zLf4
         KN7PbMyLvVZ9K7vY901ijQThM5EGjfWDVjjlBWZ/Qg8hi8cGr7ariaJugtGgyUDNAMyK
         F0lMXgVpRzxKbgbITsgJoIBTplUjOkuP+AFaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZNdnRivOoLaz/UgfxO8OxfwH7IYw5r4DIGUaxJi1cvvznAwWlIpQn9yauRn0f/d4nB
         JU3XjU02BholP6rGLRgIqCuRtnM301iS39rD6NFff00qE/aBbqbS3n+/kSS/02qdAlvz
         BkRyGz3yFbvX/ntArkqOJBmqtKJGRKocvW2w0=
Received: by 10.87.70.10 with SMTP id x10mr13603654fgk.5.1277316147522;
        Wed, 23 Jun 2010 11:02:27 -0700 (PDT)
Received: from [192.168.1.15] (abwj124.neoplus.adsl.tpnet.pl [83.8.233.124])
        by mx.google.com with ESMTPS id 26sm13783775fks.22.2010.06.23.11.02.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jun 2010 11:02:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <87bpb1issa.fsf@hbox.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149526>

On Wed, 23 Jun 2010, Martin Geisler wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>>
>>> Well, technically ".." means two different things
>>>
>>>  - for "set operations" (ie "git log" and friends) it's the "relative
>>>    complement" of two sets (or "'reachable from A' \ 'reachable from B'").
>>>
>>>  - for "edge operations" (ie "git diff" and friends) it's just two
>>>    end-points (aka "range"). A diff doesn't work on sets, it only
>>>    works on the two endpoints.
>>
>> [...]
>>> Most SCM's really talk about "ranges". Once you think in those terms,
>>> complex history doesn't work. Git very fundamentally is much about
>>> set theory, and "ranges" is a bad word to use.
>>
>> For example from I have got from asking on #mercurial IRC channel on
>> FreeNode (a bit of self promotion: I have done this research to write
>> an answer to "Git and Mercurial - Compare and Contrast" question on
>> StackOverflow[1]), Mercurial implements its ".." equivalent in the
>> term of _numeric range_, even for "hg log" (sic!).
> 
> This is fixed with Mercurial 1.6: we now have a query language where
> 'X..Y' (or 'X::Y') is understood as the set of changesets that are both
> descendents of X and ancestors of Y.

Thanks.  It looks like Mercurial's 'X::Y' is equivalent to Git's 
'--ancestry-path X..Y' (the --ancestry-path option is a new feature).
 
>> [1]
>> http://stackoverflow.com/questions/1598759/git-and-mercurial-compare-and-contrast/1599930#1599930

Fixed.  Could you please take a look if it is correct, and if there
are errors, either correct it yourself, or ask me to do it (either via
comments for this question, or via email)?  Thanks in advance.

P.S. Isn't mercurial-devel subscribe only?
-- 
Jakub Narebski
Poland
