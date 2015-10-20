From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 00/34] libify mailinfo and call it directly from am
Date: Tue, 20 Oct 2015 15:08:14 -0700
Message-ID: <CAGZ79kYXX3jDPvS1E=8oyVvjSjbMxY0Qk45Ad6cdSUq=Ee2SgA@mail.gmail.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-1-git-send-email-gitster@pobox.com>
	<xmqqh9ll6xo8.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYAW+T+sVz3c_q+P7brf6OvcQgeZEBnkM3U52vNYc0CqA@mail.gmail.com>
	<xmqqd1w96vq7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 00:08:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zof4z-00007q-Om
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 00:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754340AbbJTWIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 18:08:17 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:33760 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328AbbJTWIP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 18:08:15 -0400
Received: by yknn9 with SMTP id n9so31275789ykn.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 15:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SdtcF+Gbe0fofOImxtoXXH46U00ZKRUJ6FDvEl1Ccek=;
        b=iE0GqL0Oh8miJvqpTBFsW0JZECD4A9OOkVd0RjQEvOX1FQ81ryxU+vpQNUCyfSWK5v
         SQgVjS2yTaqT2DoJa7DiaaTyXozlMPd+DgalMHV+C1DobPqFIZ5UtKa59mj81pK7hLaf
         ex10ct1ud8vXnn1305q1T2iSJ/E9QmUGQnwJUX0xpr26aDmsC+hmOC4iwzeX4MldysDn
         9fjopkHby+yQhESQgED5GxdBR1+uV79Ct8DZT8R1m6hZoPeN8+VKkltBkcSmfii0b1Wx
         0yTwP8SZ3vf2XcqPsJcfjAKfyHHvETa4Gu0A/Rb5SXPtMtvZMK7DdUt0povvBu7kWBc0
         lVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=SdtcF+Gbe0fofOImxtoXXH46U00ZKRUJ6FDvEl1Ccek=;
        b=F8vyrnA+9fDmMs8eJT9R9IvfFl/zB5daMqyVpeDBuOupUXXScrXxJXlq3lNyUfMDRQ
         D5AEFL6Oci5J1MXkSB2pH7CBvblVaf+ZpT3OSK1Wswz7044p98Kb/b+2808gbLtqPXTU
         ErEfdZlpHnQ6hk4lPYqcwKGZYzXmlaGps9vARtBXPsCOMhCgNH3gJMrv7wV54GqZ4A/B
         zjbwGI4xqGLB4nhyqQjPQ+FaIh8XYmvdkdMKcGUg6KH8cdT+Xa6a/iFbhCpWR5yA2XAo
         a7kdYakYqa+EbawvFS4rMH69LrvbjaLTLmfk21FE886nFTd0zkRsf5XzQz74eRc4C0lF
         MAJw==
X-Gm-Message-State: ALoCoQl0qMolb6UjkZkX56yPSH2xoe87co5dNH627ECTJcT0rNp/xvduDMn/M0glnv8WlFgayATh
X-Received: by 10.129.124.8 with SMTP id x8mr4254380ywc.44.1445378894336; Tue,
 20 Oct 2015 15:08:14 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Tue, 20 Oct 2015 15:08:14 -0700 (PDT)
In-Reply-To: <xmqqd1w96vq7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279945>

On Tue, Oct 20, 2015 at 3:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> As far as I understand, this only helps for mailing list workflows, which
>> in my limited view of the world is only found in established infrastructure
>> projects, who tend to be maintained by people who run some kind of
>> ab-nomination of unix.
>> ("Are there people in Windows land who heavily use the email workflow?")
>
> Forgot that "am" is a workhorse behind "rebase"?
>

Yes, I was deceived by the name of the series ("it must be mail related and only
mail related" was my thinking).
