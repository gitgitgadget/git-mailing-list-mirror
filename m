From: Pascal Obry <pascal@obry.net>
Subject: Re: What is the best way to backport a feature?
Date: Sun, 29 Nov 2009 17:49:53 +0100
Organization: Home - http://www.obry.net
Message-ID: <4B12A631.8020200@obry.net>
References: <loom.20091129T164518-669@post.gmane.org>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Weseloh <Peter.Weseloh@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 17:50:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEmyG-0006DI-Jt
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 17:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbZK2Qtt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Nov 2009 11:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbZK2Qtt
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 11:49:49 -0500
Received: from mail-ew0-f215.google.com ([209.85.219.215]:48790 "EHLO
	mail-ew0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbZK2Qts (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 11:49:48 -0500
Received: by ewy7 with SMTP id 7so3569075ewy.28
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 08:49:54 -0800 (PST)
Received: by 10.213.101.71 with SMTP id b7mr541252ebo.78.1259513393344;
        Sun, 29 Nov 2009 08:49:53 -0800 (PST)
Received: from ?192.168.0.100? (AVelizy-154-1-43-248.w82-124.abo.wanadoo.fr [82.124.147.248])
        by mx.google.com with ESMTPS id 7sm5700605eyg.17.2009.11.29.08.49.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Nov 2009 08:49:52 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <loom.20091129T164518-669@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134023>

Le 29/11/2009 17:28, Peter Weseloh a =E9crit :
> Hi,
>
> Suppose I have the following situation:
>
>    o--o--o                    Release_1.0
>   /    \  \
> o-o-o--o--o-o-o-o-o-o---o--o Mainline
>       \       \       \ /
>        F1--F2--M1--F3--M2     Feature_A
>
> Now I want to backport "Feature_A" to the "Release_1.0" branch so tha=
t it gets
> included into the next minor release, i.e. I want to apply the commit=
s F1, F2
> and F3 onto the "Release_1.0" branch.
> I cannot just merge "Feature_A" into "Release_1.0" because that would=
 also bring
> in the merges M1 and M2 so a lot of other stuff from the Mainline.
>
> I played with cherry-pick but that means I have to manually find the =
commits F1,
> F2 and F3 (which in reality could be many more if Feature_A is big) w=
hich is not
> very nice.
>
> I also tried 'rebase -i' but that means I have to manually delete all=
 the lines
> for changesets from the mainline. Also not very nice.
>
> Is there a better way? To me this scenario sounds not unusual but I c=
ould not
> find a solution.

In such a case I would use a rebase onto:

    $ git co Feature_A
    $ git rebase --onto Release_1.0 F1 F3

Then

    $ git co Release_1.0
    $ git merge Feature_A

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
