From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Wed, 06 Apr 2011 14:53:54 +0200
Message-ID: <4D9C6262.2080408@drmicha.warpmail.net>
References: <4D9B310A.9020203@mit.edu> <1302034509-8842-1-git-send-email-asedeno@mit.edu> <4D9B7A9E.6040902@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	James Y Knight <jknight@itasoftware.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg==?= <asedeno@mit.edu>
X-From: git-owner@vger.kernel.org Wed Apr 06 14:57:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7SIg-0002m7-7U
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 14:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975Ab1DFM53 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 08:57:29 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34262 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755886Ab1DFM52 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 08:57:28 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8B51E20366;
	Wed,  6 Apr 2011 08:57:28 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 06 Apr 2011 08:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=vfruJxffLKdKkC9VEnoazlQJJy0=; b=i+9pGI32ioYGfWeqqC1r9kqjmrLvjCMCs3MHBiqYnpB0/ndf+shs0Aei3jK+v9avkNGwmO61/LYha0tAoSSh/F/llNEmLYwE+2NyVH79nAoNK4w2zootncpfghgJcXRmdqE/pDIvbYcCTTfvgKBMBnnnvd7AXnUgxSnb4KgANAk=
X-Sasl-enc: C+bGcHLvXINHz6y/tk79TW2/VzAZnMzrrKtfjDmopIuo 1302094648
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B2C8840484F;
	Wed,  6 Apr 2011 08:57:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <4D9B7A9E.6040902@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170972>

"Alejandro R. Sede=C3=B1o" venit, vidit, dixit 05.04.2011 22:25:
> On 04/05/2011 04:15 PM, Alejandro R. Sede=C3=B1o wrote:
>> @@ -730,7 +736,11 @@ sub cmd_branch {
>>  		$url =3D eval { command_oneline('config', '--get',
>>  			"svn-remote.$gs->{repo_id}.commiturl") };
>>  		if (!$url) {
>> -			$url =3D $remote->{url};
>> +			$url =3D eval { command_oneline('config', '--get',
>> +				      "svn-remote.$gs->{repo_id}.pushurl") };
>> +			if (!$url) {
>> +				$url =3D $remote->{url};
>> +			}
>>  		}
>>  	}
>>  	my $dst =3D join '/', $url, $lft, $branch_name, ($rgt || ());
>=20
> Actually, I was just finishing running this through its paces with
> different values for url and pushurl, and branching has issues:
>=20
> Trying to use an unsupported feature: Source and dest appear not to b=
e in
> the same repository (src: 'http://asedeno/svn/trunk'; dst:
> 'file:///tmp/svn/repo/branches/nb1') at /tmp/git/libexec/git-core/git=
-svn
> line 770
>=20
> So I'm continuing to look into that. Perhaps it makes sense to use pu=
shurl
> for both src and dst when branching?

=46or branching, yes. This is just the following in disguise:

http://permalink.gmane.org/gmane.comp.version-control.git/135577

"svn cp" between 2 URLs simply requires they're within the same repo.

Michael
