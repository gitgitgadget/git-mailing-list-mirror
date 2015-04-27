From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 2/4] cat-file: teach cat-file a '--literally' option
Date: Mon, 27 Apr 2015 17:27:27 +0530
Message-ID: <553E2427.4090700@gmail.com>
References: <552E9816.6040502@gmail.com> <1429117174-4968-1-git-send-email-karthik.188@gmail.com> <20150419002807.GA11634@hashpling.org> <xmqq7ft7nz8l.fsf@gitster.dls.corp.google.com> <20150420074433.GA30422@hashpling.org> <8CBC4DEB-EC50-4DD7-A687-443AA93A96A8@gmail.com> <20150420091920.GA31279@hashpling.org> <553520CF.6070304@gmail.com> <20150421101641.GA13202@hashpling.org> <CAPig+cRmPv5u_OCtUPNoYOUcOoa9xn++Xw-rkD6EP6_eq0YvEQ@mail.gmail.com> <xmqqh9s9gqw9.fsf@gitster.dls.corp.google.com> <553B78E2.5070608@gmail.com> <xmqqsiboyw90.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Charles Bailey <charles@hashpling.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 13:58:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymhfv-00054x-Rh
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 13:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbbD0L6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 07:58:07 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34334 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932549AbbD0L5c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 07:57:32 -0400
Received: by pdbqa5 with SMTP id qa5so126134976pdb.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2015 04:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=gzvubY3yGiJgaA+agE7Gnp8AvQVKfNUEobbNh1oBt8I=;
        b=Q81u2Rz1CxIm8dHBDrjRpihbzlHy2y1Ac+sJG625eR43BGbYWNp+dRtbJ1Yafx0y87
         eq6OH5nWYi43GnTSoxE+QAXONUoNfheCjftSHJEDaFM73bUYysDfuUXgpoxkh0yHiCmi
         V/vPf2Y6XweFZoTJQlB7r55Sd74Sa2NAcA0UZb8eXZQOrPHSIU1herxqdBEuDc8WtaIr
         CyEFrYbDRifOhLL6QHahcPZGlcyMyXa66AylBGSkfLLlwc5HAQ1pUZLfwnAwfKOnvoq8
         ZV5tJWN/PUirEhLUdFkKdcO6NPSwtmR3vb/NZyJsFmVaqMWNGy4tB5jdgxaHTMScVi4w
         S8dw==
X-Received: by 10.70.38.195 with SMTP id i3mr21861112pdk.82.1430135851577;
        Mon, 27 Apr 2015 04:57:31 -0700 (PDT)
Received: from [172.16.0.230] ([182.48.234.2])
        by mx.google.com with ESMTPSA id lb1sm17271638pab.39.2015.04.27.04.57.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2015 04:57:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqqsiboyw90.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267852>


On 04/25/2015 10:34 PM, Junio C Hamano wrote:
> karthik nayak <karthik.188@gmail.com> writes:
>
> >> Is there any other way to make cat-file looser other than accepting
> >> an unknown type name from the future?  If not, then perhaps it may
> >> make sense to give it a generic name that implies that we would
> >> trigger such additional looseness in the future.  But as the
> >> inventor of it as a debugging aid, I would say a name that spells
> >> out the specific way this option is being loose, e.g.
> >>
> >>>       --allow-bogus-type
> >>
> >> or with s/bogus/unknown/, best describes what it currently does.
> >
> > Yes this gives the best description, but its large, while we could use something
> > like --no-strict instead.
>
> We could, if you answered my first question with "no".
>
> By naming this "--no-strict", the first bug report you will receive
> may be that "cat-file --no-strict" should parse a zlib deflate that
> begins with "blob 1234\n\0" (notice that there are two SPs instead
> of the usual one, and length is followed by LF that should not be
> there before the NUL) but it does not.
>
> As your option name "--no-strict" signals that you will make the
> best effort to parse such nonsense, that would be a valid bug
> report, against which you would need to update the code to make it
> work.  But is it worth the effort to make such a thing work?  I
> dunno.
>
Nice point, I don't see the need to parse such objects at the moment.
That rules out "--no-strict" and everything similar.

I still find "--allow-unkown-type" a bit too big, what about something like

* --any-type
* --arbitrary-type
