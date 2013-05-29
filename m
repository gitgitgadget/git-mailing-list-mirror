From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [git-users] Highlevel (but simple to implement) commands
 provided by default for git
Date: Wed, 29 May 2013 16:43:35 -0700
Message-ID: <20130529234335.GE28153@google.com>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
 <CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
 <CAMP44s0Cx-FCZLOFZxcpC86sY+H03HKBi0nKFMgit=B5XCy71g@mail.gmail.com>
 <CALkWK0mBOB1RM+MXH+Nvos29M5vqc2yAtC__zPyowf7imfnz9Q@mail.gmail.com>
 <CAJri6_uScqjovt5eK9f9+Z4ehtsdYQNuiEX1MERiDBEJWueAXg@mail.gmail.com>
 <CALkWK0=5BwterP7ATM1GgFvLUs391w_MW4YrwbnvsbM6Q4_Opg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Br=E1ulio?= Bhavamitra <brauliobo@gmail.com>,
	git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 01:43:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhq1y-0005Vc-2D
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 01:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967108Ab3E2Xnm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 19:43:42 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:37699 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935040Ab3E2Xnk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 19:43:40 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so9928428pbb.41
        for <git@vger.kernel.org>; Wed, 29 May 2013 16:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lI7LLM5N7reDj9bPYvZxBK0ubKYg2dxcsUUiaWzwO+g=;
        b=L0D+5pQhM06FVI9fac9IKb6D5AOgwcBGMEfZsU2U9SB92oD0aga8ILAJViuWCo8Y6o
         XvKHqxyNdW80/ztjNMJN7N8edCi7QxZrg2UjxUaj2UPOgztqJAkdQt1WgBzJYT1+8bVT
         Zlu2Iu6FmfrXcqAzPlZmSjbjjzcR3/QDHfSjSOwrWobBLA8m8rj6VWPVMc2PbGADf7kl
         7YnjgxyWU2aYceeC4csAeTbEStfuVG72f4ZaL20TQl3oL1nTJ2Vs8cmNiEa1GwEh6NQy
         5fWpEAR+5c3cg1NLvSN+hY5TaJWHfKGiF4eN5Y/xO/7NIhccBHttv5JTZ5pZkDXeHDo3
         Ot/A==
X-Received: by 10.66.255.41 with SMTP id an9mr5708731pad.44.1369871020155;
        Wed, 29 May 2013 16:43:40 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ri8sm39135594pbc.3.2013.05.29.16.43.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 May 2013 16:43:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=5BwterP7ATM1GgFvLUs391w_MW4YrwbnvsbM6Q4_Opg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225898>

Ramkumar Ramachandra wrote:
> Br=E1ulio Bhavamitra wrote:

>> Agree, these aliased should work as a fallback or as an automatic sh=
ort
>> version
>
> Making builtins override'able is also a terrible idea.  It opens door=
s
> to potential bugs we don't want to deal with.  Simple example:
>
>    am =3D log -1
>    log =3D am -3

That's detectable and could be made to error out, so it's not too bad.

A bigger problem (in my opinion) with allowing arbitrary changes to
the meaning of existing commands is that scripts, whether placed in
=2Esh files or given as commands to run over IRC, stop working
altogether.  It's nice to have commands like "git log" and "git am"
mean the same thing no matter what machine I am on.

Hope that helps,
Jonathan
