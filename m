From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git diff with add/modified codes
Date: Sun, 29 Jul 2007 23:36:13 +0200
Message-ID: <200707292336.14473.jnareb@gmail.com>
References: <9e4733910707271505x4eac928axe639308afed20cb3@mail.gmail.com> <f8fn72$l30$1@sea.gmane.org> <9e4733910707281107w6aff86f5sf746ca3f2c74d098@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 00:51:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFHbP-0003w5-5x
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 00:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbXG2WvE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 18:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbXG2WvD
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 18:51:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:47141 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbXG2WvB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 18:51:01 -0400
Received: by nf-out-0910.google.com with SMTP id g13so131144nfb
        for <git@vger.kernel.org>; Sun, 29 Jul 2007 15:50:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rU9WMbIpljj2Cimrt9StFA395orbyq7fT9pn11epRcnMBMfeBGdEJWYJXd0ny5GJAIIlUQcqZV9Sni346T15V0uA+9Ycl1kF0ANU56Xwj700V62SwjE4ZXz4WD7ttpEJ3Hj45h7QNOe2fRP+c3OQaY/LX7byKLYFPFwzfu/NcNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dYHn4j7xgq5N6Dg41w7I9pVpaEoyBp2wi2fALJfDIvRBxDKe3EDJuLK/1fHpVFV31Ij6c8wGV6Dkoa+RfTZvihOjBCNUshP8I5oFBsqy4Azc0h0D1C8dmm2t4GOwdhbmQEmtRoIX2DszQhJC1Xmg26jEyEg9ZOve86k7ZJOwkPE=
Received: by 10.86.60.7 with SMTP id i7mr3483220fga.1185749459847;
        Sun, 29 Jul 2007 15:50:59 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id y2sm11106532mug.2007.07.29.15.50.53
        (version=SSLv3 cipher=OTHER);
        Sun, 29 Jul 2007 15:50:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <9e4733910707281107w6aff86f5sf746ca3f2c74d098@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54145>

On Sat, 28 July 2007, Jon Smirl wrote:
> On 7/28/07, Jakub Narebski <jnareb@gmail.com> wrote:
>> Jeff King wrote:
>>
>>> On Fri, Jul 27, 2007 at 08:17:54PM -0400, Jon Smirl wrote:
>>>
>>>> That's not what I want. I'm looking a report that indicates new files
>>>> vs modified ones in a single list. These old patches I am working with
>>>> often create 100 files and modify another 200.
>>>>
>>>> Adding a code like (Added (A), Copied (C), Deleted (D), Modified (M),
>>>> Renamed (R))  to --stat would be perfect.
>>>
>>> How about --name-status?
>>
>> Or -r --name-status?
> 
> -r is not in the git diff doc but it is used in the examples.
> http://www.kernel.org/pub/software/scm/git/docs/git-diff.html

<quote>
  <2> show only names and the nature of change, but not actual
  diff output.  --name-status disables usual patch generation
  which in turn also disables recursive behavior, so without -r
  you would only see the directory name if there is a change in a
  file in a subdirectory.
</quote>

"Of course" one knows that "git diff <tree-ish> <tree-ish>" is
git-diff-tree in disguise, and accepts git-diff-tree options.

By the way, I was thinking about extending --numstat output to include
also status. Current --numstat output is ill fitted to deal with renames
and copies, at least ill fitted for machine consumption of renames
output; it uses "old_name => new_name" as a filename for renames. While
it would be fairly easy to put pre- and after-rename names separated
by TAB, and quoted if needed (including embedded TAB character in
the filename, which would be quoted as \t instead) without breaking
anu current --numstat output parsers (although I don't think any of
them uses -M/-C), it would be hard to do the same for --numstat -z output.
A solution (not best, I admit) would be to use NUL NUL to separate pre-
and post-image filename, but I think it would be best to add new
--numstat-extended format to git-diff.

P.S. Is binary diff output described somewhere?
-- 
Jakub Narebski
Poland
