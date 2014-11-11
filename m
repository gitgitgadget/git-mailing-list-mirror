From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: Re: What is the default refspec for fetch?
Date: Wed, 12 Nov 2014 00:01:12 +0100
Message-ID: <CAENte7ggGPgNktH_ArVsjN2yDLADHQApDCzWbQLo_bbCiduk6w@mail.gmail.com>
References: <CAENte7inZ5fm2SzNPq=HNPKnPco9tM4T_es5Dphnpbia-uiLdg@mail.gmail.com>
 <20141108105221.GA20750@peff.net> <545E2A2D.2040205@gmail.com> <xmqq7fz4e18x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 00:01:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoKRN-00077Y-FM
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 00:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbaKKXBe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Nov 2014 18:01:34 -0500
Received: from mail-qa0-f44.google.com ([209.85.216.44]:36859 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbaKKXBd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Nov 2014 18:01:33 -0500
Received: by mail-qa0-f44.google.com with SMTP id w8so7680046qac.17
        for <git@vger.kernel.org>; Tue, 11 Nov 2014 15:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2+dApNti82a7hRg3HB5eOXGL8nBc8Z5MTK3KqwIK27U=;
        b=V6y0oP2xCzhWUtI5QYVAX4akhmyKn7BDQIbXr4AFtS2rqIJ/cXLDemSxoaa3vVxkQw
         iOFM00jSVcpp1tkKiBggG8IIwNcfOGhgdXejDcLUWOf/kFM4DU7iLe624/0qgnug76sR
         O1NM8nPw0cZz4pfytovCwnZI73RxSzI9jU7KLh+DOF/lbEPWlkd/4PUzIpBXmYUKM1HA
         B5y0+D7RHkQ9JGgblJLP49xy4bdspJhnl+bzEvgz6hbG1VPVVGVUf1KpLh1S1Z9R38al
         WFWIsx289pp5tWFm9zOKFBVHz0JyDgYXdu5rGGVJAK6iW/QdLDejMSrJyoN78oSoXWiZ
         oNfQ==
X-Received: by 10.229.64.134 with SMTP id e6mr10202201qci.11.1415746892453;
 Tue, 11 Nov 2014 15:01:32 -0800 (PST)
Received: by 10.96.149.71 with HTTP; Tue, 11 Nov 2014 15:01:12 -0800 (PST)
In-Reply-To: <xmqq7fz4e18x.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ok, thanks. Then I'll teach JGit to fetch at least "HEAD" if nothing
is configured and nothing explicitly specified as refspec.
Ciao
  Chris


On Sun, Nov 9, 2014 at 6:23 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jakub Nar=EAbski <jnareb@gmail.com> writes:
>
>> W dniu 2014-11-08 11:52, Jeff King pisze:
>>> On Fri, Nov 07, 2014 at 04:31:08PM +0100, Christian Halstrick wrote=
:
>>>
>>>> In a repo where no remote.<name>.fetch config parameter is set wha=
t
>>>> should a "git fetch" do? My experiments let me think it's
>>>> "HEAD:FETCH_HEAD". Right?
>>>
>>> Basically, yes. We always write FETCH_HEAD, regardless of the refsp=
ec.
>>> We choose "HEAD" if no other refspec was provided. So it is really =
more
>>> like
>>>
>>>    git fetch $remote HEAD
>>>
>>> This is what makes one-off bare-url pulls work, like:
>>>
>>>    git pull git://...
>>>
>>> It runs fetch under the hood, which writes into FETCH_HEAD, and the=
n we
>>> merge that.
>>
>> Actually FETCH_HEAD consists of multiple lines, one per ref...
>> but only top ref is merged.
>
> Incorrect in that "only top" is misinformation, and irrelevant in
> the context of discussing the "what is fetched in a one-off fetch".
