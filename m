From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 2/2] interpret-trailers: add option for in-place editing
Date: Tue, 19 Jan 2016 13:10:49 -0500
Message-ID: <CAPig+cRozqCKdC2+nyG-UM6xFo_sSqa7OhGgcycyyDQujZHtHA@mail.gmail.com>
References: <1452790676-11937-1-git-send-email-tklauser@distanz.ch>
	<1452790676-11937-3-git-send-email-tklauser@distanz.ch>
	<xmqqio2vki0i.fsf@gitster.mtv.corp.google.com>
	<CAPig+cRRdca7PfkqppY2X7KSFpHX0yH19fxRL+w_=u9vg7NV9A@mail.gmail.com>
	<xmqqio2pbgov.fsf@gitster.mtv.corp.google.com>
	<CAPig+cRi2knygjeaMtojAr65BE71B-z7q+s8V5rcGrV9Qja6jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tobias Klauser <tklauser@distanz.ch>,
	Christian Couder <chriscool@tuxfamily.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 19:11:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLakY-0003aN-GU
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 19:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932792AbcASSLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 13:11:22 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:32939 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932702AbcASSKv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 13:10:51 -0500
Received: by mail-vk0-f65.google.com with SMTP id n1so13150877vkb.0
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 10:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=KSAKKyIhVrq2tJcJyYfIP5hrRDonbjws7Xeq7MCSB+Y=;
        b=PwvQwk8rLcIyPhVZPKIL0wsnhKus+TnlGNv4qLH80h9AKo5dRhHOKqYdM0kURTTWtl
         hOGZkp19VelLr956eIB8iWIHVXJc9WEP5JhLn9GuBdvQHCAV8s7jB1hBzrLY+lim8c7X
         o3o+zJgh/KJu9MCy87vG2SFC+/ASHIwNxAfA+XaL6kuymXIO0EKUlVHUCuRzUq8TlakR
         dgcT/ZFc9IGrWCaBCj9HgZoz7LbFbYH+wN/krsCaOf/JOgnI2EPqsWpOLGAgEwFN9Pzn
         J6X+OsV8mHjFNI1jNzdlpHILNWV3T72QblddnolB8tu1ggM0yZPomP8GroW6ftRotysE
         drSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=KSAKKyIhVrq2tJcJyYfIP5hrRDonbjws7Xeq7MCSB+Y=;
        b=HHZFmg+nvlR0x+i/Zzr20F3MtHT1N8LzjpgRdY+Qw/66KT2OAWoCPM54yvYyAipXnK
         pr5b2OeXtDsSp3wnB2JEc05HkMHqMZkJkGFC1pnH/yxJCn6ZeWVwPDgGTlsOUAzGdAtj
         5q8XCTGcaxG3MxM6jx4vzcH5g0WzbrcDPm1qtajUnTzRs6ft7iU3cVWCT4cAXsrDlWL6
         vYSYudhGyHIWB1ooo/EJw0SWu6gsf2hTsSrdV37NmuJVjQapBN/XAAvMH0MtZ7fFpdLx
         7Y6Pa08B/xxM3+N9STU3yVRkU3ifaJ8oWD4Z0gWa6yT8VY/dMr7+4QJaaygwHSSpVV3U
         HkcA==
X-Gm-Message-State: ALoCoQlkyIdZf61Mrtjz72lqW6Tx0gTT5C6aFF7qgz7GmI1lvJeYHR9j7egvX0rb2PphzgrhkRVRAxcNVyLmzUP13d9JMkiZsw==
X-Received: by 10.31.56.18 with SMTP id f18mr18432020vka.19.1453227049855;
 Tue, 19 Jan 2016 10:10:49 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 19 Jan 2016 10:10:49 -0800 (PST)
In-Reply-To: <CAPig+cRi2knygjeaMtojAr65BE71B-z7q+s8V5rcGrV9Qja6jw@mail.gmail.com>
X-Google-Sender-Auth: 2MrVr1FDZhVFxupNRCrRoI5gFfg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284365>

On Tue, Jan 19, 2016 at 12:56 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jan 19, 2016 at 12:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> I think POSIXPERM is all you need for this case; SANITY doesn't buy
>>> you anything, if I understand correctly.
>>>
>>>>> +     cat basic_message >message &&
>>>>> +     chmod -r message &&
>>>>> +     test_must_fail git interpret-trailers --trailer "Reviewed-by: Alice" --in-place message &&
>>
>> The purpose of "chmod -r message" is to force interpret-trailers to
>> fail due to its input being unreadable; without SANITY, i.e. running
>> this test as root, the command would happily read from message that
>> is marked as unreadable by anybody, and test_must_fail will not pass.
>
> Makes sense. I never run tests as root, thus wasn't thinking along those lines.

On reflection, this doesn't make sense to me. Perhaps I'm missing
something obvious.

My understanding is that SANITY is an expectation that directory
permissions work in an expected POSIXy way: that is, a file can't be
deleted when its containing directory lacks 'write', and a file can't
be read/accessed when the directory has neither 'read' nor 'execute'.
This doesn't say anything about root not being allowed to read a file
when the file itself lacks 'read'.

As far as I can tell, as coded, this test will *always* fail as root
since root will always be able to read 'message'.
