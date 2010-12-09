From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other operators
Date: Thu, 9 Dec 2010 12:43:43 +0100
Message-ID: <201012091243.44824.jnareb@gmail.com>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com> <201012090144.19858.jnareb@gmail.com> <AANLkTin1SjEzBnLd-HK9fANShLezAKHAOai9MyF-cuoT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 12:44:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQeum-0001EX-Vy
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 12:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267Ab0LILn4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 06:43:56 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:64863 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab0LILnz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 06:43:55 -0500
Received: by fxm18 with SMTP id 18so2249571fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 03:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=SjzJgh7k5IvkNlz/CjbBWrRFin+7iCntu6VXKAKjuX0=;
        b=msp7so7q/1mYII/JmQ7Uwwkc64K/IZbjIVDgywzc2TKtDMJyZtbGFmjtbA5SKlhU0P
         BgeidA9sLObeVzRXDTPfyVyNVYpwngRZ4W5f/aN2AYkiZgaazMbxSyvl/JbEnQeL4d48
         u2AIl1IqFGXOqGF6dk3CqDg9m0UIvPAx/+tfU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jbncNt/mF1whnTzjj1J+HeR34wibn9JjBwT7eSNpa+ijl71U2UINzCiCY5V1emk82j
         ovA1G12Kmhfv/9x+umc3D3bPmbW+o/aEmHu9sZ1CmfvpbrEK5z9GgidVkLrD7nFgR6tb
         KTmhzzb4K6GZlElNPaoErRzA8FfK8OeVLCllo=
Received: by 10.223.69.134 with SMTP id z6mr1910771fai.19.1291895034031;
        Thu, 09 Dec 2010 03:43:54 -0800 (PST)
Received: from [192.168.1.13] (abvw115.neoplus.adsl.tpnet.pl [83.8.220.115])
        by mx.google.com with ESMTPS id 5sm497491fak.47.2010.12.09.03.43.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 03:43:52 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTin1SjEzBnLd-HK9fANShLezAKHAOai9MyF-cuoT@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163276>

On Thu, 9 Dec 2010, Nguyen Thai Ngoc Duy wrote:
> On Thu, Dec 9, 2010 at 7:44 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:
>> On Thu, 9 Dec 2010, Nguyen Thai Ngoc Duy wrote:
>>> 2010/12/9 Jakub Narebski <jnareb@gmail.com>:
>>
>>>> I wonder if it would be possible to make :/<regex> (which looks a =
bit
>>>> like searching the index) to be an alias to --all^{/<regex>}...
>>>
>>> It looks a bit strange to my eyes to merge normal option name with
>>> revision syntax. But I think it's possible. Do we allow branch/tag
>>> name with leading '-'?
>>
>> Well, with below proposal it would simply be
>>
>> =C2=A0--all ^{/<regexp>}
>=20
> This hardly works with range and may conflict with "--all" being
> already used by some commands.

It is '--all' like in "git log --all".
=20
The proposed semantics for ^{/foo} (i.e. not attached to revision)
would be that it acts on all positive revs on the left of it, replacing
them.  But that might be not easy to do, and it feels a bit=20
overengineered.

> I think we can move '/' out of {}, the space between '/' and '{' can
> be used for optional parameters: ^/{foo}.

Do you mean using e.g. ^/:i{foo} for :ignorecase, instead of ^{:i/foo}
or ^{i/foo}?

--=20
Jakub Narebski
Poland
