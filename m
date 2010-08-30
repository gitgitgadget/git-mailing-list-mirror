From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] test-lib: use subshell instead of cd $new && .. && cd
 $old
Date: Mon, 30 Aug 2010 11:04:44 -0500
Message-ID: <20100830160444.GE3292@burratino>
References: <1283169642-21917-1-git-send-email-avarab@gmail.com>
 <20100830155723.GC3292@burratino>
 <AANLkTi=z9uUB_YZ9Sb0O8JzaEjazKDzqB=ZVtqTTDf2K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Carl Worth <cworth@cworth.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 18:07:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq6sy-0001UQ-RG
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 18:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755863Ab0H3QGc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 12:06:32 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38803 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693Ab0H3QGb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 12:06:31 -0400
Received: by wyb35 with SMTP id 35so6759459wyb.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 09:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=GKRwUrsa1BSD36bfp1lMx1Xwf9UnqeY+thuRzlSuGGo=;
        b=g+AvR9gWeUVjp4IHJkTg6tbZ0HUESaPnXqeRlxYXN8bFa24CZmGb6nK3Tt9/6UKP+j
         iJXr7ufWJT0U/SUjjpjYmMUjCT8O32Hywq1QgHBcWIscJDdUk6elJUcOzmaSy2tlwx3I
         T5tNx97jIYN/AQMbW11R+GJ4+RCxnz0/Q3uGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=IxoAVXveOUDMyBqL7Qscq7JS/uUAGQtnT1+rOCu8qjSlaiQHc315Fo0j/obf5L5LiU
         JzwOf1a5LNFV31s3sWeP86eRTXfcEGxybioHKuWpbOelgZ8GaaEetbr9f74yBcWZ9WnB
         XdGlrkps92bslOBajKZGKejU3XVE+4m8lo5lg=
Received: by 10.227.138.5 with SMTP id y5mr4927756wbt.204.1283184390532;
        Mon, 30 Aug 2010 09:06:30 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u11sm4555033weq.7.2010.08.30.09.06.28
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 09:06:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=z9uUB_YZ9Sb0O8JzaEjazKDzqB=ZVtqTTDf2K@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154826>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Aug 30, 2010 at 15:57, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>>> - =C2=A0 =C2=A0 cd "$repo" || error "Cannot setup test environment"
>>> + =C2=A0 =C2=A0 (cd "$repo" || error "Cannot setup test environment=
"
>>> =C2=A0 =C2=A0 =C2=A0 "$GIT_EXEC_PATH/git-init" "--template=3D$GIT_B=
UILD_DIR/templates/blt/" >&3 2>&4 ||
>>> =C2=A0 =C2=A0 =C2=A0 error "cannot run git init -- have you built t=
hings yet?"
>>> - =C2=A0 =C2=A0 mv .git/hooks .git/hooks-disabled
>>> - =C2=A0 =C2=A0 cd "$owd"
>>> + =C2=A0 =C2=A0 mv .git/hooks .git/hooks-disabled)
>>
>> Style: why not use
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cd "$repo" ..=
=2E
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0... .git/hook=
s-disabled
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0)
>>
>
> I've seen both used and I don't know which is preferred.

Okay.  I maintain that the latter is way more readable.  Is there any
advantage to the former?

Whichever the project chooses can be enshrined in
Documentation/CodingGuidelines, of course.
