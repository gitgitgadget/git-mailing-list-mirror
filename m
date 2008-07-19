From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Sat, 19 Jul 2008 02:03:33 +0200
Message-ID: <200807190203.35758.jnareb@gmail.com>
References: <4876B223.4070707@gmail.com> <200807150141.39186.jnareb@gmail.com> <20080718165407.GU10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Jul 19 02:04:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJzwL-0005It-Ma
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 02:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425AbYGSADq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2008 20:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754659AbYGSADq
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 20:03:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:30985 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693AbYGSADp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 20:03:45 -0400
Received: by fg-out-1718.google.com with SMTP id 19so238356fgg.17
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 17:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=P7cEhW9mTeStY9uECsbQoWhQ1I6awMkQdudiXEdYcUE=;
        b=MHGhKbcbKJ1jhmlq8duc365vWpdAyjaxNKyWPbFxxgHxgX1jgH9jSF0lmp2KZLvzpf
         OOo1sfNagQEmJZc7wtgsyw+ZvnKmaAX4+bjXI4xirNdPRR+rwF8OjdvXyGyMPY+OhhsC
         Y6n+x2NiND3IhJsWifFKzn3dTNtEIPGOdBO3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=e1p23ppJKmRNbxiVUULmA4P7NHUC9LALfdALs1Yr0x7tyiO5cZ8RzSBoGErQ0Dsgz7
         2ym4gkRn/ctWkRrfGkTDxVMkQ0+xQA8l1Tqj4F6M16GNZxzVw5K+fGCmDw4Zt+FglC8b
         FTtTcqlD2F09lLnIheI4uxp0SmEmNs44kofik=
Received: by 10.86.58.3 with SMTP id g3mr1199958fga.21.1216425823651;
        Fri, 18 Jul 2008 17:03:43 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.220.24])
        by mx.google.com with ESMTPS id d6sm2833115fga.2.2008.07.18.17.03.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jul 2008 17:03:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080718165407.GU10151@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89088>

Petr Baudis wrote:
> Jakub Narebski wrote:

>> [...]
>> $r =3D Git::Repo->new(<git_dir>);
>> $r->output_pipe('ls_tree', 'HEAD');
>> [...]
>> $nb =3D Git::Repo::NonBare->new(<git_dir>[, <working_area>]);
>> $nb->output_pipe('ls-files');
>>=20
>>=20
>> How can it be done with minimal effort, unfortunately I don't know..=
=2E
>=20
> Well, this interface is almost identical to what I delineated, except
> that I have the extra ->cmd-> step there. But maybe, we could go with
> your API and instead have Git::CommandFactory as a base of Git::Repo?
> The hierarchy would be
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0Git::CommandFactory - provides the cmd_pipe t=
oolkit
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|
> =A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0Git::Repo =A0 =A0 =A0 - provides repo=
sitory model
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|
> =A0=A0=A0=A0=A0=A0=A0=A0Git::Repo::NonBare =A0- additional working-co=
py-related methods
>=20
> I think I will post a sample implementation sometime over the weekend=
=2E

What I would want from the solution is an easy way to set up path
to git binary for _all_ git command calls, and for invoking command
which does not need git repository to run (like git-ls-remote).

--=20
Jakub Narebski
Poland
