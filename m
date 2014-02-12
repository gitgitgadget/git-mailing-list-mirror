From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] gc: config option for running --auto in background
Date: Wed, 12 Feb 2014 08:53:05 +0700
Message-ID: <CACsJy8CyAsA5VA-s_c7juaRyToRU+QzJsYZDvzD5ggaR6=9FOg@mail.gmail.com>
References: <xmqqd2j2afup.fsf@gitster.dls.corp.google.com> <1391843332-20583-1-git-send-email-pclouds@gmail.com>
 <1391843332-20583-2-git-send-email-pclouds@gmail.com> <CABPQNSb3=i8F+vPEG3RmH+snZVZ-xrPtcVY2Nx9uvyTCLXcy6g@mail.gmail.com>
 <CACsJy8BBQ3Bh6q6JM8V-QVKfzwp1w99+u4_55jjGbHLV3c62gA@mail.gmail.com>
 <xmqqob2est9c.fsf@gitster.dls.corp.google.com> <CAPc5daW3VwLutU8JZu9fBbGtihw5X_bE9M31ugzqN9mEnFYNNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	chris <jugg@hotmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 02:59:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDP6Z-0003qM-75
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 02:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbaBLB7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 20:59:11 -0500
Received: from mail-qa0-f54.google.com ([209.85.216.54]:35527 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbaBLB7K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 20:59:10 -0500
Received: by mail-qa0-f54.google.com with SMTP id i13so13028696qae.27
        for <git@vger.kernel.org>; Tue, 11 Feb 2014 17:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3kVq9XyNuD7R5u2BR0dENXkmOa1FNPRbcR5AyMR6TbU=;
        b=ZnpIR1xBjxqPF3Nsu2K+K2kwvHN39ahOcSaadRDrYrSeXED49V10wjJetnQAWtnKb/
         oSRythiXy2U06wI2OphnCv1EJPaL7H3lzq4jNVVlumdgyaPrlAfYpxWjd7CdDI1qAwbu
         3iToXNVF7liPqD2+YHxwMadDwILUsH3YNeBU6BzuFYH3JmgR+cJ0uvGIinkwmR0s9bS1
         Qfw1v/HP62l+/dYWa1xmdvq1F7mKQIQaF0jldBH6p1KfNYdR1wfUgfTHfJbBQ9y3Jh/5
         tEjwiSt2UM/jLkl8IylEJgY7qi0bKRLTuE/H87UkdpzDUN0NbIeuRooUXbEePK1CD+jN
         3WRA==
X-Received: by 10.140.47.212 with SMTP id m78mr59441883qga.21.1392170015368;
 Tue, 11 Feb 2014 17:53:35 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Tue, 11 Feb 2014 17:53:05 -0800 (PST)
In-Reply-To: <CAPc5daW3VwLutU8JZu9fBbGtihw5X_bE9M31ugzqN9mEnFYNNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241967>

On Tue, Feb 11, 2014 at 2:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> On Mon, Feb 10, 2014 at 10:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> If --quiet is set, we should not be printing anyway. If not, I thinkg
>>> we could only print "auto packing in background.." when we actually
>>> can do that, else just print the old message. It means an #ifdef
>>> NO_POSIX_GOODIES here again though..
>>
>> Didn't you change it not to die but return nosys or something?
>
> Ah, the problem is that it is too late to take back "... will do so in
> the background" when you noticed that daemonize() did not succeed, so
> you would need a way to see if we can daemonize() before actually
> doing so if you want to give different messages.
>
> "int can_daemonize(void)" could be an answer that is nicer than
> NO_POSIX_GOODIES, but I am not sure if it is worth it.

Or we could pass the "quiet" flag to daemonize() and let it print
something in the #ifdef NO_POSIX_GOODIES part.
-- 
Duy
