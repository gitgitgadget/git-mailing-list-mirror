From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git-upload-pack died of signal 13
Date: Thu, 7 Jun 2012 07:22:25 +0530
Message-ID: <CAMK1S_hL1Ug7-+Rs2Y_pXso01Pur4-Fs58ADtV8fcYUvBSmwcA@mail.gmail.com>
References: <4FCF3ED7.9060503@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Tajti_=C3=81kos?= <akos.tajti@intland.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 03:53:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScRuF-0002P2-Ty
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 03:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759435Ab2FGBwz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jun 2012 21:52:55 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37637 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294Ab2FGBw0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jun 2012 21:52:26 -0400
Received: by obbtb18 with SMTP id tb18so165928obb.19
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 18:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=AhbT7xdS7cuPkjitpGFaoLpQ4ZK1dQMhjHdfgSBYHQY=;
        b=UfpDWCqOi+bTFmkIIvgl3DiNMOjkrN411l+IILAjh8aRlD7BoYdHizDURH412fCRB2
         y7cAMMUewllMwsJ+nDR0DJJlaUqQvKMgtq10GjdIQgCaEbxC4DxmwekF0Lw7ZJg4IQYD
         KbIjbzmk+jJjjIdYlGj0pdreiUCCGDrT8FOSGg/vRmPWgv5SuQrD7Wp2UDVzhXFhbWKD
         3KezzvpEJKxmAe+0d0J0mJqQ8u7ekw81fjwLBzdCfknEiSjYLVZ9+98eyewYaHCCqFLV
         qOSQ5hKWmkUgnWupl/V5Gy0hDDTfWF+4GQj/cNv9ZPQPqsH78oIM4soyTteJFx8ND9vO
         4S/g==
Received: by 10.60.19.226 with SMTP id i2mr314233oee.20.1339033945807; Wed, 06
 Jun 2012 18:52:25 -0700 (PDT)
Received: by 10.182.108.67 with HTTP; Wed, 6 Jun 2012 18:52:25 -0700 (PDT)
In-Reply-To: <4FCF3ED7.9060503@intland.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199365>

On Wed, Jun 6, 2012 at 4:58 PM, Tajti =C3=81kos <akos.tajti@intland.com=
> wrote:
> Dear List,
>
> we got "git-upload pack died of signal 13" error when pushing using t=
his
> command:
>
> =C2=A0Executing: "/usr/lib/git-core/git-http-backend" env:
> "CONTENT_TYPE=3Dapplication/x-git-upload-pack-request"
> "GIT_HTTP_EXPORT_ALL=3Dtrue" "SERVER_PORT=3D443"
> "CODEBEAMER_SMART_SCM_SERVLET=3Dtrue" "REMOTE_ADDR=3D91.82.170.74"
> "REMOTE_HOST=3D91.82.170.74" "SERVER_SOFTWARE=3DApache Tomcat/6.0.35"
> "SERVER_NAME=3Dcodebeamer.com" "GIT_PROJECT_ROOT=3D/home/akos/reposit=
ory/git"
> "REMOTE_USER=3Dzl" "PATH_INFO=3D/cbdev-git/git-upload-pack" "QUERY_ST=
RING=3D"
> "AUTH_TYPE=3DBasic" "GATEWAY_INTERFACE=3DCGI/1.1" "SERVER_PROTOCOL=3D=
HTTP/1.1"
> "REQUEST_METHOD=3DPOST" "CONTENT_LENGTH=3D1157"
> "REQUEST_URI=3D/app/git/my-git/git-upload-pack"
>
> What may be the cause?

a post-receive script that does not consume its STDIN is the usual
cause of a SIGPIPE error.

Try adding "cat >/dev/null" into it if you really don't care about the =
input.

("kill -l" will tell you what the names are for each number).

>
> Thanks in advance,
> =C3=81kos Tajti
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml



--=20
Sitaram
