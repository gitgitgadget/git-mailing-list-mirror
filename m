From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 2/2] interpret-trailers: add option for in-place editing
Date: Tue, 19 Jan 2016 12:56:18 -0500
Message-ID: <CAPig+cRi2knygjeaMtojAr65BE71B-z7q+s8V5rcGrV9Qja6jw@mail.gmail.com>
References: <1452790676-11937-1-git-send-email-tklauser@distanz.ch>
	<1452790676-11937-3-git-send-email-tklauser@distanz.ch>
	<xmqqio2vki0i.fsf@gitster.mtv.corp.google.com>
	<CAPig+cRRdca7PfkqppY2X7KSFpHX0yH19fxRL+w_=u9vg7NV9A@mail.gmail.com>
	<xmqqio2pbgov.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tobias Klauser <tklauser@distanz.ch>,
	Christian Couder <chriscool@tuxfamily.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 18:56:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLaVz-0004gF-JP
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 18:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbcASR4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 12:56:20 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33277 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271AbcASR4T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 12:56:19 -0500
Received: by mail-vk0-f67.google.com with SMTP id n1so13134112vkb.0
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 09:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=X2OecK4QP3JaP8p3uR6mNy4WrzJyCvkB8t/3tBGMt0Y=;
        b=YRknVQnX6IpMYAC0ECcBoGzEQB8H/6wodZziOUVfuS3IUmT1uhwLMFxXO+IwZiBRU1
         0k9Zz0djSHFV0AM0vzvKDfM5/nXvMKnYxKMG4t32Kmb6/lFamPQJcCL2ESBzCEzwTFhj
         jqYMoOatj23DsyehIW6Ka0zwt37CrjmkfSEFD+KknCAgoMaF2+GMpEJh55/pv7z3F0HR
         /iMVaM/sHCRYWQatVdg9xTGvuU3eYrFuJNek5R+4VPMpBQeQn4IGSDGOlk6z7Lqod7Ui
         S3M77PvemDbPWifCFkqyki/Oaiz2pCZLKUV8T91t82J5h7yFL7Qysc+mC1Td3h/s7iyW
         c1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=X2OecK4QP3JaP8p3uR6mNy4WrzJyCvkB8t/3tBGMt0Y=;
        b=hv0BWozxeiCJ3em02Vzyy65gTquhn55gMy91/b0PZkGMaH4fJPKXO1HovcQGj7YjLY
         xlSyG47aptL6L1E76cCKmSDIGz0Npzs9ie5ukJN3PyDxUVHikUYTNqxbjMWYqCJqG3Hr
         WBM6Olr5laWuHxJaaSmLa6lvDRc+5Np8O2Gmi04pHgmM1CiFJgcgturyXDlpV2j1D+Wq
         XBw+3gbYg8uqeKDOQMI97KRRWVmWDB18HNoi/zdEjjZJljQdaT5hkk3Z/e3pYCCzx6QD
         TGV0+RGq76NIpXQWvMXdDq/+fEx60gzej5i4XWuBcxc+YYO5mhoV99lyUmq0n7qublVU
         kMZQ==
X-Gm-Message-State: ALoCoQnTer0WQLbodDz1TKksHTqd+DswlFeGvUj9k05vb2mUkPzcBtMHENGGwOqMNjqBTt8zRXbnMdNOSZ4SL1WQ7b/U+MG8sg==
X-Received: by 10.31.58.74 with SMTP id h71mr21364557vka.151.1453226178373;
 Tue, 19 Jan 2016 09:56:18 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 19 Jan 2016 09:56:18 -0800 (PST)
In-Reply-To: <xmqqio2pbgov.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: f9Ik215R0P4MNsK6lOqssfFu3WY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284364>

On Tue, Jan 19, 2016 at 12:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> I think POSIXPERM is all you need for this case; SANITY doesn't buy
>> you anything, if I understand correctly.
>>
>>>> +     cat basic_message >message &&
>>>> +     chmod -r message &&
>>>> +     test_must_fail git interpret-trailers --trailer "Reviewed-by: Alice" --in-place message &&
>
> The purpose of "chmod -r message" is to force interpret-trailers to
> fail due to its input being unreadable; without SANITY, i.e. running
> this test as root, the command would happily read from message that
> is marked as unreadable by anybody, and test_must_fail will not pass.

Makes sense. I never run tests as root, thus wasn't thinking along those lines.
