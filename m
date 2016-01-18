From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 2/2] interpret-trailers: add option for in-place editing
Date: Mon, 18 Jan 2016 17:13:22 -0500
Message-ID: <CAPig+cQ5X7r22pXyCs_n+-mXK3Lzh1CpAMQ_PbuhLT4C3S+v1Q@mail.gmail.com>
References: <1452790676-11937-1-git-send-email-tklauser@distanz.ch>
	<1452790676-11937-3-git-send-email-tklauser@distanz.ch>
	<xmqqio2vki0i.fsf@gitster.mtv.corp.google.com>
	<CAPig+cRRdca7PfkqppY2X7KSFpHX0yH19fxRL+w_=u9vg7NV9A@mail.gmail.com>
	<CAPc5daWpnReWJzeTJjvZap78H0oZKG-YGEP19Neusyahu5A6cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tobias Klauser <tklauser@distanz.ch>,
	Christian Couder <chriscool@tuxfamily.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 23:13:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLI3E-0004Mg-Bg
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 23:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbcARWNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 17:13:25 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36670 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932415AbcARWNX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 17:13:23 -0500
Received: by mail-vk0-f65.google.com with SMTP id e64so9799769vkg.3
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 14:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=d5ZkArA4WA8DhtHR0S8yxf140Q5V+wUiysG6Z+DtHas=;
        b=Rmdt5ltrHaKjXKXjvg6NJeB0dgq/QnA/RJmd2foUlwfKFCxV5i1e3D57M9BbP1T/me
         ag7v1RpNq20GeEraoni2UDLGxxkrSiV3p/+Kr/GDTS7+6z5FFsuOEXVZ3GA0Q32VOkUo
         y0vT8DHcu0PCr5diF7RvwJXPugZ4siePzMV3jQue4fr+Qrp3fGJ3kgZM2NL7FpcbLb/K
         f+oFePBbmhcdkPctn26H3EUS5ywl88fzAgvzNTsTaefl7k7GeJcG82YD8IvUddhMBpHC
         c6DtQuvPk30zWKcVLvlTaXA9rGnsrL3GIFI7TJYDZcaGsFVYWLOXDNGplI3ph3EvIA9R
         6MNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=d5ZkArA4WA8DhtHR0S8yxf140Q5V+wUiysG6Z+DtHas=;
        b=mCsnPpjxw8V3nuJL74inr/RXwQBqzQzHVIiMq/jUWcJ5CZGQ+/rDCDIOE7kPac70C5
         moFjpfY/HCZMRxtv8+OjhkILJGOL0GAlI2VnpU3mpGcqxkECTGqz4mDN6KKE02kd+MbM
         216x+RmW2WF9r0ypHbKQfHEsPqxp0LRLFLkxk21Tm6TUBXxbOKBwt2R7H28V2udbQqDj
         N1rFxOuWt73L0ewbf07G/CMg3anzcV3FFBG0vNdNkNWMJwAACJ9II1mLyxsVCQhohHf6
         47uagCUkf5PYpandFQ6PlEchTZmFNBKTNOzSVya6l+8Iv+ne4LYvWB1U08FCc2eMpcTY
         BlGA==
X-Gm-Message-State: ALoCoQmjgCaW1OTvOaCRF8dBe7vDahU2+XUiOKfazVtlWd7Kcy0G6Ew7ftCnF+ZvXEYQWtFq0MKYHnO3I9IGjk2yp4+ZsmM6HQ==
X-Received: by 10.31.141.2 with SMTP id p2mr18431945vkd.37.1453155202924; Mon,
 18 Jan 2016 14:13:22 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 18 Jan 2016 14:13:22 -0800 (PST)
In-Reply-To: <CAPc5daWpnReWJzeTJjvZap78H0oZKG-YGEP19Neusyahu5A6cQ@mail.gmail.com>
X-Google-Sender-Auth: M1kro7MTQr4jiEXkNV8wOUdieSs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284332>

On Mon, Jan 18, 2016 at 4:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Jan 18, 2016 13:11, "Eric Sunshine" <sunshine@sunshineco.com> wrote:
>> On Thu, Jan 14, 2016 at 3:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> If for some reason interpret-trailers fails to fail, this would
>>> leave an unreadable 'message' in the trash directory.  Maybe no
>>> other tests that come after this one want to be able to read the
>>> contents of the file right now, but this is an accident waiting to
>>> happen:
>>>
>>>         cat basic_message >message &&
>>> +       test_when_finished "chmod +r message" &&
>>>         chmod -r message &&
>>>         test_must_fail ... &&
>>>         chmod +r message &&
>>
>> Don't forget to remove this (now unnecessary) "chmod +r" once you've
>> added the 'test_when_finished "chmod +r"'.
>>
>>>         test_cmp ...
>
> It still is necessary for the test-cmp to work, no?

My bad. Ignore me.

By the way, isn't the:

    cat basic_message >message &&

in the above test just an unusual way to say:

    cp basic_message message &&

?
