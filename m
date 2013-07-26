From: =?windows-1252?Q?J=F6rn_Hees?= <dev@joernhees.de>
Subject: Re: [PATCH v3] remotes-hg: bugfix for fetching non local remotes
Date: Fri, 26 Jul 2013 14:16:59 +0200
Message-ID: <2428D514-68F9-43C7-B59D-C316BE03BCAA@joernhees.de>
References: <1374712977-3215-1-git-send-email-dev@joernhees.de> <CAMP44s16bRx0p_F=PTcy9bekg_5TVC_GsQjzOev6xkpCEWcjAw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, apelisse@gmail.com
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 14:17:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2gxW-0001As-Ow
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 14:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757321Ab3GZMRT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jul 2013 08:17:19 -0400
Received: from srv1.joernhees.de ([81.20.133.80]:52875 "EHLO mail.joernhees.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757094Ab3GZMRR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jul 2013 08:17:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.joernhees.de (Postfix) with ESMTP id 014ECE8C2F0;
	Fri, 26 Jul 2013 14:17:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at joernhees.de
Received: from mail.joernhees.de ([127.0.0.1])
	by localhost (srv1.joernhees.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OvS1M3GMASX9; Fri, 26 Jul 2013 14:17:03 +0200 (CEST)
Received: from [192.168.83.24] (dfki-098.dfki.uni-kl.de [131.246.194.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.joernhees.de (Postfix) with ESMTPSA id 6F36AE8C2E1;
	Fri, 26 Jul 2013 14:17:03 +0200 (CEST)
In-Reply-To: <CAMP44s16bRx0p_F=PTcy9bekg_5TVC_GsQjzOev6xkpCEWcjAw@mail.gmail.com>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231183>


On 25 Jul 2013, at 21:12, Felipe Contreras <felipe.contreras@gmail.com>=
 wrote:
>> [=85]
>> ---
>> contrib/remote-helpers/git-remote-hg | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-h=
elpers/git-remote-hg
>> index 0194c67..f4e9d1c 100755
>> --- a/contrib/remote-helpers/git-remote-hg
>> +++ b/contrib/remote-helpers/git-remote-hg
>> @@ -390,7 +390,7 @@ def get_repo(url, alias):
>>         if not os.path.exists(dirname):
>>             os.makedirs(dirname)
>>     else:
>> -        shared_path =3D os.path.join(gitdir, 'hg')
>> +        shared_path =3D os.path.join(gitdir, 'hg', '.shared')
>>         if not os.path.exists(shared_path):
>>             try:
>>                 hg.clone(myui, {}, url, shared_path, update=3DFalse,=
 pull=3DTrue)
>> --
>> 1.8.3.4
>=20
> I don't like this approach because if it's a huge repository the user
> would have to clone again, not only if he was using v1.8.3, but also
> if he was using the latest and greatest (because you are changing the
> location again). t's relatively trivial to move from the old to the
> shared organization, so that's what I vote for. Besides, I don't see
> the point of having a '.shared/.hg' directory, and nothing else on
> that '.shared' folder.

Agreed=85 it just was the shortest possible fix with an in my POV minor=
 optimisation drawback of once refetching...
