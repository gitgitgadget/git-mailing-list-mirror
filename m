From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/8] refs.c: rename the transaction functions
Date: Thu, 11 Dec 2014 13:48:54 -0800
Message-ID: <CAGZ79kZVWzvneL=1_5Wp7ANw2A67pjZi08A6g5Y5YN670+RnXQ@mail.gmail.com>
References: <1417833995-25687-1-git-send-email-sbeller@google.com>
	<1417833995-25687-3-git-send-email-sbeller@google.com>
	<xmqqbnn9eudc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 22:49:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzBbZ-0005Dr-3X
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 22:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933969AbaLKVs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 16:48:56 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37210 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933134AbaLKVs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 16:48:56 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so417033igb.11
        for <git@vger.kernel.org>; Thu, 11 Dec 2014 13:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PV7rZUktN5F9Paa2eoy7mcUofn7rZ6fXdO5+iCGb3qI=;
        b=QGdJLcA1dgJcllq6QvF8J6+RC0upBj8Ioq7h5wEMB/U2um9oDOjsUnXhGRPbBEiyDP
         gmb4LBYRweSHYGpNJAimp0tqjsiYLHSy+9NNMIEUp1Op5GAcoezuo5gGt63oTJ7KVEJe
         5zc1lnRtDHI6/VLl1kjVayJ2fiPGNG5njn022OfNE4GUAWV5x3zPWMyfWyLpDnfJeANg
         e9FyEh6XEbNobYCI2+6M7DP73NCudjyHndkcO6UoQ6tbbFnoibnwKZkQoQepR4VHwwvk
         8qE47lY88RcnOAMZBfIN0/Grsf1Bsi+CwMtKh9zurAYlVs/OURiymqFjftbh00zjoi1w
         gRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=PV7rZUktN5F9Paa2eoy7mcUofn7rZ6fXdO5+iCGb3qI=;
        b=Idd5wAmpWev5lKKDs6o1Cy8PnWXwWg0IQEvPy5zBzwevcXpcH1snU4Mr58OY3usM1f
         6MeB+81WhvmmW2j5Jv/i2rxQjLVbhVbFzEDQ8AnviYXMiyyeLiPa+VLRv54lxCsqksxe
         XLEuBkjW0JdfvL0vXvCG6iLOks2gT1YydcrFIqvPQnfex1yYCMyVLU+0UV9JfQTu/py6
         eHJaBpm8Rui1Dtr5Oh78fTYoAhRWXZW5Wkf+CbyEXdk0htRFjjjtX8KbOeri4VEyiZ1E
         vWbEwRP9zUSgpCVr7PKD59/cIXChS57Pg4ZXk31SNrpaftdgNbRDvgerwxy74E/Pxd7R
         Wl/Q==
X-Gm-Message-State: ALoCoQlf7s6tC2cM13YC4t+0pFrr4VPd1CRrXOgSp0g5wsdQkMJQueOX9tkUxGZiy1tYeSYJX6t9
X-Received: by 10.50.4.102 with SMTP id j6mr1262364igj.37.1418334535039; Thu,
 11 Dec 2014 13:48:55 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Thu, 11 Dec 2014 13:48:54 -0800 (PST)
In-Reply-To: <xmqqbnn9eudc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261294>

On Thu, Dec 11, 2014 at 1:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Rename the transaction functions. Remove the leading ref_ from the
>> names and append _ref to the names for functions that create/delete/
>> update sha1 refs.
>>
>> The goal in the long term is to have different things running through
>> the transaction api, such as the .git/config file.
>>
>> The dream is to...
>
> I was trying to polish somebody else's topic that does not have
> anythning to do with refs/reflogs/transactions today, and had to
> suffer from conflicts from the textual difference between
> transaction_begin and ref_transaction_begin, which I feel is totally
> unnecessary at this moment.
>
> I'd really prefer to see this done long after all the dust from
> "ref" changes from various people have settled, especially given
> that we are not doing anything for that "dream" right now.
>
> Thanks.

Good point. For the last days I was trying to write less invasive
patches as I guessed this may become a problem.

Feel free to drop these patches,
I'll resend them later if they still make sense.
