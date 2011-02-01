From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Tracking empty directories
Date: Tue, 1 Feb 2011 20:03:46 +0100
Message-ID: <201102012003.50941.jnareb@gmail.com>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com> <AANLkTi=u6=mhOd9LFYRy48y41xRcXmYDtktOKoBjjMgO@mail.gmail.com> <20110201183508.GE3771@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 20:09:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkLbN-0004GS-5m
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 20:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916Ab1BATJP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 14:09:15 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54062 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab1BATJO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 14:09:14 -0500
Received: by wyb28 with SMTP id 28so7025906wyb.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 11:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=7vbvarmPkbV7q9ENLliw337q+F93vx/+ROZLNNJzdGU=;
        b=Jshvd9rWRbbASS4MB/AjLUNpAG6UsPTwXV/DeDhw1xwg1M1FXj8QbBZksf8QTnfYfH
         K0/2F4T0OemveZNOwmvD22u7yXjVsjw3AwGWKbreR9M1gw/ciiPXlRLbHgAczWFtzPtj
         U4/fAGkuGa4DNAdi27tb/+mTI+wjaCpWWiCRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=bcCspU3XGY9ENcHdPR3hgJ5RyI5soGl0COFBzFfWFOSIvIS+HM1nObuZQrnRn1FWNm
         hwcxDk+/MNYf7HSiq3xIxkJI2S0fvgZJnWjQpBijtVUqo3xxk4O16jXm9u/ZTEtvrVH7
         TMqezONDyiUhNfvURryUdV15o8PV8nLxpthkg=
Received: by 10.227.11.143 with SMTP id t15mr8160299wbt.27.1296587043353;
        Tue, 01 Feb 2011 11:04:03 -0800 (PST)
Received: from [192.168.1.13] (abuz232.neoplus.adsl.tpnet.pl [83.8.197.232])
        by mx.google.com with ESMTPS id o6sm4657572wbo.15.2011.02.01.11.04.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 11:04:02 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20110201183508.GE3771@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165846>

Dnia wtorek 1. lutego 2011 19:35, Jonathan Nieder napisa=C5=82:
> Nguyen Thai Ngoc Duy wrote:
>> On Wed, Feb 2, 2011 at 12:28 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>=20
>>> I have ideas about how to resolve those tricky corner cases, but no=
t
>>> about what the UI should look like. =C2=A0How does one go about add=
ing a
>>> directory? =C2=A0Does it ever get implicitly removed?
>>
>> I suppose a special command for it is appropriate (git-keepdir?). Ma=
ny
>> index-related commands are recursive by default and hard to change.
>>
>> Yes I think it should be automatically removed from index when a fil=
e
>> is added inside tracked directories. Removing those files will also
>> remove the containing directory though.
>=20
> Okay, I'm convinced.  This fits a "worse is better" point of view
> nicely.
>=20
> To add, one would use "git update-index --add".

Porcelain version could be "git add -N <directory>", don't you agree?

> The magic disappears when you register a file within that directory;
> to tell git you want to keep it, one would mkdir and
> "git update-index --add" again.  Once it's working, we can think abou=
t
> if there is a need for making that last step automatic after all
> (my guess: "no"). ;-)=20

Hmmm... could we use mechanism similar to assume-unchanged to mark
directory as explicitely tracked, and that git should not remove it
when it becomes empty?

--=20
Jakub Narebski
Poland
