From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 0/2] thin-pack capability for send-pack/receive-pack
Date: Wed, 6 Nov 2013 15:42:30 -0800
Message-ID: <CAJo=hJtUMZit8Mtt7NQ=SiAXmnHf3xQqCKMo3F3XksHoq0tCkw@mail.gmail.com>
References: <1383750263-32495-1-git-send-email-cmn@elego.de>
 <xmqqbo1x8e60.fsf@gitster.dls.corp.google.com> <1383774082.2850.10.camel@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Nov 07 00:46:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeCkW-0002wr-Fv
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 00:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109Ab3KFXmx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Nov 2013 18:42:53 -0500
Received: from mail-wg0-f45.google.com ([74.125.82.45]:47077 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab3KFXmw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Nov 2013 18:42:52 -0500
Received: by mail-wg0-f45.google.com with SMTP id z12so216917wgg.24
        for <git@vger.kernel.org>; Wed, 06 Nov 2013 15:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=An7H0JZXvZ1V0c1eVI+766Jin/ndQoVcQ7B4ag3Q+ro=;
        b=fFH2OT+7YrsDVdy8q+Ik9IBPw2Zjau0r3/CwtpKfL2cHpzsmJtKn2R0GtbFMdnWoby
         3/f0PZ52p4vXJuLwgzIW90kgbqOlKPMi/Nmg8vpP8HlioqiN7ynis1RQozSZjeC82Qy0
         ZNSLKIhltx3VQ3bcLEveuSxxQyM8mogn4Pxt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=An7H0JZXvZ1V0c1eVI+766Jin/ndQoVcQ7B4ag3Q+ro=;
        b=Vg8o87JZkPYtY9OD8qqevJ6iREqldTQW2IZclQ7IkTrbbk2bQ2hyZot2cYeIW5OQfG
         1wynIY3hjz04QejL1M+Lqzorw/xzqny1EsSckH9wyiYQrQuheS1sZGq/KhOIPG14oBjn
         PwMpyjqtHhVNegqeQtZsGMw5h+rCwvrURPJMWo8a7S2xPgspSf+zazMoTwWPxnBO7AJD
         nwkQpZWSolbUGLhspYdVZokalYITQWpnR3tfCOivYai6PAXol36JJpB4/7PRe4K66e/B
         U85frtv33tFJ3HLDNeINhVD68RQhvvGqzaL4wYkEdOUWJsAYPXbKVC3+H4FyiMLyXgDG
         +lyQ==
X-Gm-Message-State: ALoCoQlZ/7FPgx001X1dkKosmgsnazZxpSy/xhDwuUkZye6+ZyeITH2uI4o6p8pXq7Ij1W25kenN
X-Received: by 10.194.82.8 with SMTP id e8mr27647wjy.95.1383781370988; Wed, 06
 Nov 2013 15:42:50 -0800 (PST)
Received: by 10.227.62.140 with HTTP; Wed, 6 Nov 2013 15:42:30 -0800 (PST)
In-Reply-To: <1383774082.2850.10.camel@centaur.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237383>

On Wed, Nov 6, 2013 at 1:41 PM, Carlos Mart=EDn Nieto <cmn@elego.de> wr=
ote:
> On Wed, 2013-11-06 at 12:32 -0800, Junio C Hamano wrote:
>> I'll queue these for now, but I doubt the wisdom of this series,
>> given that the ship has already sailed long time ago.
>>
>> Currently, no third-party implementation of a receiving end can
>> accept thin push, because "thin push" is not a capability that needs
>> to be checked by the current clients.  People will have to wait
>> until the clients with 2/2 patch are widely deployed before starting
>> to use such a receiving end that is incapable of "thin push".
>>
>> Wouldn't the world be a better place if instead they used that time
>> waiting to help such a third-party receiving end to implement "thin
>> push" support?
>>
>
> Support in the code isn't always enough. The particular case that
> brought this on is one where the index-pack implementation can deal w=
ith
> thin packs just fine.
>
> This particular service takes the pack which the client sent and does
> post-processing on it to store it elsewhere. During the receive-pack
> equivalent, there is no git object db that it can query for the missi=
ng
> base objects. I realise this is pretty a unusual situation.

How... odd?

At Google we have made effort to ensure servers can accept thin packs,
even though its clearly easier to accept non-thin, because clients in
the wild already send thin packs and changing the deployed clients is
harder than implementing the existing protocol.

If the server can't complete the pack, I guess this also means the
client cannot immediately fetch from the server it just pushed to?
