From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: retrospective move
Date: Wed, 4 Feb 2009 11:31:43 +0100
Message-ID: <adf1fd3d0902040231h2fb6f199oee143e36a7501a2a@mail.gmail.com>
References: <21826423.post@talk.nabble.com>
	 <200902041017.47564.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: jemmyw <jeremy@boost.co.nz>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 04 11:33:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUf4C-0002Iq-CH
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 11:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbZBDKbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 05:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbZBDKbq
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 05:31:46 -0500
Received: from mu-out-0910.google.com ([209.85.134.186]:36873 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbZBDKbp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 05:31:45 -0500
Received: by mu-out-0910.google.com with SMTP id i10so342782mue.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 02:31:43 -0800 (PST)
Received: by 10.103.172.9 with SMTP id z9mr2903498muo.39.1233743503117; Wed, 
	04 Feb 2009 02:31:43 -0800 (PST)
In-Reply-To: <200902041017.47564.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108332>

2009/2/4 Thomas Rast <trast@student.ethz.ch>:
> jemmyw wrote:
>>
>> Hi. Awhile ago I copied some files in my local repo then commited. In another
>> commit I deleted the original files, so essentially I did a mv that git
>> doesn't know about. Now I'm trying to merge from another branch where
>> changes have happened to the files in their original locations, and it's
>> making the merge somewhat difficult. Is there a way to ease this?
>
> Git never "knows" about a move, it only detects them after the fact.
> A corollary of this is that 'git mv a b' is more or less the same as
> 'cp a b; git rm a; git add b'.
>
> Now since you have a copy followed by a removal in two separate
> commits, the merge logic won't treat this as a rename.

I don't think it holds. Git only sees the endpoints and the bases, it
does not matter if the "move" was actually two commits. Maybe they
have changed dramatically and git is not able to detect the rename (or
the files are small). Another possible cause could be that you have a
lot of renames (see config merge.renamelimit).

You could see if git detects the rename diffing differents commits:

$ git diff --raw -M commit1 commit2

if it does not detect you could use other limits as:

$ git diff --raw -M50 commit1 commit2

while commit1 and 2 are the endpoints or the merge base.

It could hep if you could provide a minimal test case, or at least the
commands and output you get.

HTH,
Santi
