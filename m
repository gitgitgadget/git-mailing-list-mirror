From: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
Subject: Re: [usability bug] git branch -a does not disambiguate remote and local branches
Date: Mon, 15 Dec 2008 22:15:40 +0300
Message-ID: <85647ef50812151115k41451d84jcfbdd9a187813e00@mail.gmail.com>
References: <85647ef50812151015t4d5bc2b8p4ea53a0e4ad25e64@mail.gmail.com>
	 <alpine.DEB.1.00.0812152005490.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 20:17:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCIwB-0004uH-6U
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 20:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbYLOTPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 14:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbYLOTPn
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 14:15:43 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:50435 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbYLOTPn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 14:15:43 -0500
Received: by fk-out-0910.google.com with SMTP id 18so1597538fkq.5
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 11:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=GeYp73eYOqnzwyfhX0q000UoiHDtlHx1LGrOg9dyQcQ=;
        b=WCGo3N10TzULhWQRjl4giamYr7i1VD9UWB151uabcXnIwqMW3+Wg+Nkd1bcDCYOUgy
         ZB+K0Dg0q9QxpDz+ZdP4G03DkV9BTjnM7OLBO420r20S7A9E2eZV8bpY+ZnQf92lsOfI
         Ic5kndHGGnRvT/JK5rea1wQ08+D+Tz4+5IR08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Z0W/5kZ4jY0LRgLCkLUcYnKq5q1puWUzwQtc/0xyGySswMnRQ1h7wR5e6Hq/9tudnx
         1fJEwT0NsIUzIumd4c7nGOisuYjdRmQ5WaemoShpzF5G5wA3W/w272aXbbzug/z0AErH
         Hzl/R2m4ngd8kW3BWqlXbeB0SNopEcjFygpE0=
Received: by 10.181.139.10 with SMTP id r10mr2641703bkn.64.1229368540436;
        Mon, 15 Dec 2008 11:15:40 -0800 (PST)
Received: by 10.181.143.16 with HTTP; Mon, 15 Dec 2008 11:15:40 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0812152005490.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103197>

On Mon, Dec 15, 2008 at 10:09 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 15 Dec 2008, Constantine Plotnikov wrote:
>
>> Let's consider the following scenario:
>>
>> mkdir bare.git
>> mkdir local
>> cd bare.git
>> git --bare init
>> cd ../local
>> git init
>> echo test > test.txt
>> git add test.txt
>> git commit -m test
>> git remote add origin `pwd`/../bare.git
>> git push --all
>> git checkout -b origin/master master
>> echo updated > test.txt
>> git add test.txt
>> git commit -m updated
>>
>> Note that that in this scenario, the user has created local branch in
>> the folder with the same name as a remote branch. While the supposed
>> user here is apparently shooting itself in the foot, the scenario is
>> still supported by git, and might happen as a result of more logical
>> git operations (like git fetch).
>
> It is only half-supported, and Git will complain, saying that there are
> ambiguous branches.
>
> IMHO it is better to be nice to the many users who do not try to shoot
> themselves in the foot, by showing them the nice short names that will
> work.
>
> The others are warned when they use the ambiguous short names anyway.
>
It is possible to be nice to to both categories showing shortest
disambiguated output like:

  master
* heads/origin/master
  remotes/origin/master

Constantine
