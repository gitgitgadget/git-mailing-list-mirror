From: Semyon Kirnosenko <semyon.kirnosenko@gmail.com>
Subject: Re: [BUG] difference of info from diff and blame
Date: Wed, 12 Jan 2011 10:53:44 +0300
Message-ID: <4D2D5E08.9040804@gmail.com>
References: <4D2C333A.3010401@gmail.com> <201101111440.08619.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: trast@student.ethz.ch
X-From: git-owner@vger.kernel.org Wed Jan 12 08:53:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcvWh-0001ko-36
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 08:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755606Ab1ALHxp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jan 2011 02:53:45 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45580 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521Ab1ALHxo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 02:53:44 -0500
Received: by wyb28 with SMTP id 28so276907wyb.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 23:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=1CXw+R9S4ELvD7QpfudQr7nj31Aj6snYCPPwWoAkPic=;
        b=KetVyhvCiKfDIeJ5r6szrutMFZ5uP6MZugmn4zZ7GBYDkGXL7Gafz70TktHMO4tmpl
         j7I0ELPVWluo3k4IwdPtRFv1xN05pyqFCg3xKLrBMKRAZZkb3QvXu084U2lraHZ/HOT3
         0z87LBrx2FLA/7tMWmqJljOgbxR7XBK8XYIwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=nvj7gR+yLAoPlW6lxj4bJb1QhYxlm0wiqVS2M76kFBhwkPpwbRaXDkn8SpFtfmiNxN
         udm4kCsV54ESXEmzO4gt9RvzbX54MJxgDTcU/sWStbG65Rw3+1QZBwfFrdeied6SY3HU
         kTMLD1K4oemuxBnV1anIDffrlrtGO4GEkOKGE=
Received: by 10.227.58.73 with SMTP id f9mr576795wbh.171.1294818823127;
        Tue, 11 Jan 2011 23:53:43 -0800 (PST)
Received: from [46.147.22.98] ([46.147.22.98])
        by mx.google.com with ESMTPS id n78sm160661weq.27.2011.01.11.23.53.41
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 Jan 2011 23:53:42 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; ru; rv:1.9.2.4) Gecko/20100608 Thunderbird/3.1
In-Reply-To: <201101111440.08619.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165005>

11.01.2011 16:40, Thomas Rast =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Semyon Kirnosenko wrote:
> [Word wrap fixed.]
>>
>> I have jquery repo (https://github.com/jquery/jquery.git)
>> Let's get blame for some file in some revision:
>> git blame -l -s 2ad223aedd1f93c783d98d60adc9fda3bdfbb4b6 -- src/even=
t/event.js
>> According to blame, line 127 was added in revision
>> 2ad223aedd1f93c783d98d60adc9fda3bdfbb4b6.
>
> The surrounding context (with authorship and some whitespace snipped,
> obviously it's always the same) is
>
> 2ad223ae (124)	=09
> 2ad223ae (125)		// Pass along a fake event
> 2ad223ae (126)		data.unshift( this.fix({ type: type, target: element =
}) );
> 2ad223ae (127)
> 2ad223ae (128)		// Trigger the event
> 2ad223ae (129)		if ( (val =3D this.handle.apply( element, data )) !=3D=
=3D false )
> 2ad223ae (130)			this.triggered =3D true;
>
>
>> Let's get diff for that revision:
>> git diff-tree -p 2ad223aedd1f93c783d98d60adc9fda3bdfbb4b6 -- src/eve=
nt/event.js
>> We can see this:
>> @@ -105,19 +120,16 @@ jQuery.event =3D {
>>
>>    		// Handle triggering a single element
>>    		else {
>> -			var handler =3D element["on" + type ], val,
>> -				fn =3D jQuery.isFunction( element[ type
>> +			var val, ret, fn =3D jQuery.isFunction( element
>> +		=09
>> +			// Pass along a fake event
>> +			data.unshift( this.fix({ type: type, target:
>>
> [this blank context line is line 127 in the postimage]
>> -			if ( handler ) {
>>
>> As you can see line 127 is not marked with '+' char, which means it =
was
>> not added in this revision. But blame sad otherwise.
>
> git-blame internally runs a diff with no context lines to "pass
> blame".  On all lines in this diff, the current commit can pass on
> blame to the parent, thus avoiding having to take it for itself.
>
> And indeed, running
>
>    git show -U0 2ad223ae -- src/event/event.js
>
> in your repository gives a hunk
>
> @@ -108,11 +123,8 @@ jQuery.event =3D {
> -			var handler =3D element["on" + type ], val,
> -				fn =3D jQuery.isFunction( element[ type ] );
> -
> -			if ( handler ) {
> -				// Pass along a fake event
> -				data.unshift( this.fix({ type: type, target: element }) );
> -=09
> -				// Trigger the event
> -				if ( (val =3D handler.apply( element, data )) !=3D=3D false )
> -					this.triggered =3D true;
> -			}
> +			var val, ret, fn =3D jQuery.isFunction( element[ type ] );
> +		=09
> +			// Pass along a fake event
> +			data.unshift( this.fix({ type: type, target: element }) );
> +
> +			// Trigger the event
> +			if ( (val =3D this.handle.apply( element, data )) !=3D=3D false )
> +				this.triggered =3D true;
>
> So I would tend to agree with the blame implementation.  If anything
> it's a bug in git-diff when not using any context.
>
> Do you have a reproduction recipe that exhibits the flaw on a
> non-whitespace line?  I'm not up to speed on the diff implementation
> (maybe someone else can help?), but I wouldn't be too surprised if it
> had heuristics that put lines consisting only of whitespace at a lowe=
r
> importance than "actual" lines.
>

All cases I have seen were about whitespace lines.

--=20
Regards,
Semyon Kirnosenko
kirnosenko@mail.ru
