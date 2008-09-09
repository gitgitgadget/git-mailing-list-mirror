From: "Steven Walter" <stevenrwalter@gmail.com>
Subject: Re: Revert behavior
Date: Tue, 9 Sep 2008 18:30:05 -0400
Message-ID: <e06498070809091530n57913304r2eb3920898a3225d@mail.gmail.com>
References: <51419b2c0809090626p2196c590j7569fb471e470f0d@mail.gmail.com>
	 <200809091538.13961.jnareb@gmail.com>
	 <20080909212834.GC10544@machine.or.cz>
	 <e06498070809091439q1c543807pd6e74b7ada32434@mail.gmail.com>
	 <7v63p53r93.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, "Jakub Narebski" <jnareb@gmail.com>,
	"Elijah Newren" <newren@gmail.com>,
	"Govind Salinas" <govind@sophiasuchtig.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 00:31:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdBjx-0006Ua-5T
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 00:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbYIIWaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 18:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753457AbYIIWaI
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 18:30:08 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:58929 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358AbYIIWaH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 18:30:07 -0400
Received: by gxk9 with SMTP id 9so12061495gxk.13
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 15:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Bu3uhse3Y/RmlPNa0GqlvKf/jm84/qzcfMrS/UH2RqM=;
        b=tYr6ukyWHEUnR4XOVh8W6g1njyRa+uLlCuLrSp9uL7XZS8+JWXIvNUG67P1osM6/NQ
         x85TYC2Wstg7INJbnSwlcJcgitWmlEOpttsyqEgQDY3wZUwFTUeA5O6RPZHDY/FaieAw
         wm5Uw5bOxf1599ZiBpadHQPwl3IoAHuGTAzqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=iwHmJz7eJcuFgFg667LEyqlgxqP+UBLRL8FHwLjSJpHix+2D4NupqwwwYp7gF40Sxv
         fhPnLA7D1Ov3h8HcNZ89BQdMiA6W3FuDz2pevQgU+PU66NxBlV+M76gZhrlrY4mRy9ZS
         SrCWaq2sR2VqGtOBRtwpBc26h0e+47LrfmEAc=
Received: by 10.90.90.4 with SMTP id n4mr382452agb.51.1220999405536;
        Tue, 09 Sep 2008 15:30:05 -0700 (PDT)
Received: by 10.90.25.17 with HTTP; Tue, 9 Sep 2008 15:30:05 -0700 (PDT)
In-Reply-To: <7v63p53r93.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95450>

On Tue, Sep 9, 2008 at 6:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> If you implement "eg svn-like-revert" to checkout the given paths out of
> the last commit, instead of the index, shouldn't that be sufficient?

eg's "revert --since <commit> <path>" command is actually most similar
to "svn update -rXXX path."  In this case, except for the special case
where commit is HEAD, it is not sufficient; checking the path out of
the last commit would not be what the user wanted.

>> It it a delicate balance to have the user interface match both the
>> mental model of the user and the storage model of the tool.
>
> I do not think it is that simple.
>
> You could match the user experience to the mental model of the other tool,
> by hiding the differences and insisting that people use only your tool.
>
> The real issue is that you may need to castrate the underlying tool in
> certain places if its world model is richer than the model the tool you
> are trying to emulate.  Ignoring the index by making "svn-like-revert"
> work on both index and the working tree file at the same time is a good
> example of that.
>
> If the castrated feature is truly too exotic and rarely useful for mere
> mortals, that strategy works very well.  A simpler world model that lets
> you do the same job equally well is a much better UI than the needlessly
> complex one.  But if that is not the case, your users would eventually
> graduate out of the training wheel and would want to use that feature you
> hid away from them, and at that point they need to unlearn parts of the
> simpler world model and shift their world view somewhat.  If you try to
> support both classes of users, that become hard.

Indeed so.  Hiding the index is not a design goal of yap.  However,
neither is it absolutely necessary to understand the distinction
between "staged" and "unstaged" changes to use yap.  If a use never
runs the "stage" command, everything would work as he expects.
Achieving this is as simple as making "yap commit," in the presence of
only unstaged changes, do the equivalent of "git commit -a."  If it
turns out that _wasn't_ what the user wanted, salvation is only a "yap
uncommit" away.

In your position as an integrator, what is a necessary tool for you
may indeed be an exotic command for another user.  For example, users
who primarily interact with svn repositories (a target demographic for
yap), "merge" is not terribly useful given the information loss when a
commit is eventually "pushed" to subversion.  I do not hide merge
functionality, but neither is it emphasized as a standard part of the
workflow (there is no "pull" command).

> I have to admit that I used to have my own Porcelain when git was very
> young, not because I did not like existing UI git had, but there was no UI
> back then.  "My own" Porcelain is relatively easy -- I have to only cater
> to my own needs and need to expose only the limited subset of the features
> the underlying tool (in this case, the storage model and history view of
> git) I understand, and nobody complains that he cannot access the parts I
> do not expose to him.  Growing it to satisfy wider audience is the hard
> part.

No argument that supporting an audience greater than 1 is considerably
more difficult.  Indeed I intend and hope to support users other than
myself with yap, else I would not have gone to the trouble of
announcing it.  However, without concrete discussion on where yap
hides too much or "castrates" a feature in a way that hinders learning
of the lower-level tools, there's only so much one can do.
-- 
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
 -Robert Heinlein
