From: "Steven Walter" <stevenrwalter@gmail.com>
Subject: Re: Revert behavior [Was: Re: [ANNOUNCE] yap: Yet Another (Git) Porcelain]
Date: Tue, 9 Sep 2008 17:39:46 -0400
Message-ID: <e06498070809091439q1c543807pd6e74b7ada32434@mail.gmail.com>
References: <51419b2c0809090626p2196c590j7569fb471e470f0d@mail.gmail.com>
	 <200809091538.13961.jnareb@gmail.com>
	 <20080909212834.GC10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Elijah Newren" <newren@gmail.com>,
	"Govind Salinas" <govind@sophiasuchtig.com>, git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 09 23:40:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdAxD-0002f5-VV
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 23:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463AbYIIVjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 17:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753457AbYIIVjt
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 17:39:49 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:54730 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbYIIVjs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 17:39:48 -0400
Received: by gxk9 with SMTP id 9so11938234gxk.13
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 14:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=faDYztOIIdsbGC9PUClz33CjaNHTVxpFHrSALIBsxM4=;
        b=qgy0xXo2XI9zqkcSPPrHCJrC4imW3RyM91JkvZjZZYuqlH4b4s+E5mJvLyZK2iVQFz
         K4b2RFLgZD4fH5s1HBW1wBFFHQ1OxSntJ6XJxA71yJT3h2r0qSTAqiME7hMkCNH8DkTG
         2tyNuw9l/KWlDZD9ekLHrQMLYflwzgB2+/0Ec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IpcXHdUsyDE+6ka33uw66+scqPIW7DWosr7rnbfVWqLkMV7m0iw9MTiB+TpVi1uxKc
         AAKhD3SzjEm74x8OPd5e3/XUgMbxc11bxH4hQLD7tB161Lf03TbpvTYfVvCqUf2AiPfE
         h7PNmcnuvcd3NnDTqT9/QB8X8CEvTJ8CfhQOE=
Received: by 10.90.65.14 with SMTP id n14mr285062aga.99.1220996386612;
        Tue, 09 Sep 2008 14:39:46 -0700 (PDT)
Received: by 10.90.25.17 with HTTP; Tue, 9 Sep 2008 14:39:46 -0700 (PDT)
In-Reply-To: <20080909212834.GC10544@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95444>

On Tue, Sep 9, 2008 at 5:28 PM, Petr Baudis <pasky@suse.cz> wrote:
> On Tue, Sep 09, 2008 at 03:38:13PM +0200, Jakub Narebski wrote:
>> By the way, I think the fact that in different SCMs meaning of
>> "$scm revert" and of "$scm reset" differs widely caused Mercurial
>> to adopt "hg backout" for creating a commit which reverts changes
>> (cherry-pick -R), and "hg rollback" to undo last commit.
>
> This brings up a point I wanted to raise - sometimes when the meanings
> across the systems (including Git) are too conflicting, it should be
> considered to use a completely different command name whatsoever to
> reduce the confusion. This is e.g. the reason Cogito had no "pull"
> (but "update") or "checkout" (but "restore" and "switch") commands.

I agree with this.  That's part of the problem I have with schemes to
make commands work similarly to other SCMs.  If you give, for example,
eg a mode to act like "svn revert;" that all well and good until the
user runs "git diff" and you're made a liar.  In svn, there would be
no diff, because the files all match their respective upstream
versions.  In git, you would see changes because the file no longer
matches the last commit.

It it a delicate balance to have the user interface match both the
mental model of the user and the storage model of the tool.  That's
what all of these projects, (git, cogito, yap, eg, pyrite) are
attempting to do.  I don't know of an objective way to measure success
in this attempt, other than simple popularity.  Popularity suggests
that the git porcelain is the most successful, and I would agree
regarding storage model, but I am not convinced that it best matches a
typical SCM user's mental model.
-- 
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
 -Robert Heinlein
