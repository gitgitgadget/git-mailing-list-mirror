From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git name-rev not accepting abbreviated SHA with --stdin
Date: Fri, 03 Jul 2015 10:36:41 -0700
Message-ID: <xmqqbnft5eja.fsf@gitster.dls.corp.google.com>
References: <558A2405.2090709@gmail.com>
	<xmqqsi9g8x51.fsf@gitster.dls.corp.google.com>
	<558B60E4.9020604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 19:36:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZB4tO-00079E-Ei
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 19:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592AbbGCRgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 13:36:45 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33700 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810AbbGCRgo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 13:36:44 -0400
Received: by igcur8 with SMTP id ur8so148675500igc.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 10:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=kYuFNsZatNHVPMyEWepV9+OcKq4mNuNVgGo1kruRjcM=;
        b=SoMfVwg3evI0xFNog6P+c/pc/W6X1FWYL3UeCwbRnTZXwFrJvG9jKaufjTRSgFq1jU
         QCM+sjmGlFSyBBE6tm0quSanoGpDGe4eWAwEJVJe0Rl9gKM/XaG1CEHUfUTXKWJDS3z0
         57qnqJhIQRUgqHDlnAGohHTQzjXCAQeHEBuVpoj786IJ5MzHywyT2glBU8SWWQhUTAiI
         w135Kq57RC4HX1SoZLcQ8BOY8Z+DFpXXOe/FlrmqXr48DJvwsrzeDxsjvVRh5UQoYzs1
         SFJXGL/fJJPJ2xZPBBdcaNT5HzoUgWSIV+/Mhf9VBiQ8kxY3CY2LYruD0PYNVbP745Wi
         PFjw==
X-Received: by 10.42.163.137 with SMTP id c9mr18703359icy.51.1435945003479;
        Fri, 03 Jul 2015 10:36:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:846f:c5d0:52c9:d18a])
        by mx.google.com with ESMTPSA id s5sm3861832igh.6.2015.07.03.10.36.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 Jul 2015 10:36:42 -0700 (PDT)
In-Reply-To: <558B60E4.9020604@gmail.com> (Sitaram Chamarty's message of "Thu,
	25 Jun 2015 07:31:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273299>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> On 06/25/2015 05:41 AM, Junio C Hamano wrote:
>> Sitaram Chamarty <sitaramc@gmail.com> writes:
>> 
>>> This *is* documented, but I'm curious why this distinction is made.
>> 
>> I think it is from mere laziness, and also in a smaller degree
>> coming from an expectation that --stdin would be fed by another
>> script like rev-list where feeding full 40-hex is less work than
>> feeding unique abbreviated prefix.
>
> Makes sense; thanks.  Maybe if I feel really adventurous I will,
> one day, look at the code :-)

Sorry, but I suspect this is not 100% laziness; it is meant to read
text that has object names sprinkled in and output text with object
names substituted.  I suspect that this was done to prevent a short
string that may look like an object name like deadbabe from getting
converted into an unrelated commit object name.
