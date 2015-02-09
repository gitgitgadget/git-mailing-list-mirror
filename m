From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 09/11] ref_transaction_delete(): check that old_sha1 is
 not null_sha1
Date: Mon, 9 Feb 2015 10:37:39 -0800
Message-ID: <CAGZ79kZ-MrCjxzwOqsfP7x72tSJiwawCb3e=XiK6+4F1B8z7gQ@mail.gmail.com>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
	<1423412045-15616-10-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 09 19:37:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKtDM-0003bV-AA
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 19:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933762AbbBIShk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 13:37:40 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:39710 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbbBIShj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 13:37:39 -0500
Received: by iecar1 with SMTP id ar1so18745197iec.6
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 10:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ECKCqUSQ7H6Cf0z3aeWdFNtpHNREQs346gV7toTJCpk=;
        b=Vrn0d3RJ2WIG/6oNtQ3J1UVuRMcp/FBGbLx6G+1L74eg7eeDEQfFPKMuexThTWXrBZ
         KoeuJQMCpQx60PsS9/fOfKvq8yw1oj5fOAaAn8/oriDD0LCt6/HfYdmSCp9vQrx/7/Oi
         Lc1N53Tzix0nxW/lqj2kLEVgt2kHIxJQOpWfTabQLim97La/uFrSgKf7Cztm7xFCieYG
         huJ/ur/+mC/M1ecdwWx9fdu5EWwVpvwfZLeECy5QXXGxbygfZqK5mxBcC5++EFpk2dWA
         YCUlUBPY91+gMrfvbU6RqiLWF5aSyrWNr0XguOJUcDjcetiOmAt7U3g0M22b44bjTPQC
         YjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ECKCqUSQ7H6Cf0z3aeWdFNtpHNREQs346gV7toTJCpk=;
        b=a29usTN0IeyAF1V7R3g90X3UYeV11FSA2+B75ao3bMwKgiexbDDZsWrYs3LqPLuW+V
         Ee3HxmjOExGcWlXVNOr8y+DSikzlHvD2/Uf89mUgJaPfLvd3Phkrwbuf9W+26sirTcyh
         yFdVEECJU+WFiC3ysY0GfAlm8nrQGJSsDFevZsSXcY5TifWGGJAdRzxF/G+7kSeYmU/I
         wMWEyUHnu/Qqe6eq1rOY85vVsRjmir+5CycWTXhh69TaxHcWJfEq/tZUo1DPmdvYYZI3
         NxI9hau3YgSFCzMh8MtpoyDCP9s8bEXl18mvHJEznB1tJVvRwN4Y6sm7zK9MCVYsjMMT
         CaAg==
X-Gm-Message-State: ALoCoQmUm0WBylKFAFot1kiqrJKVevZ1KMXYfojTwYUAV4dpC7olXBwN3lw8ik7+JAmANV7jS7Sl
X-Received: by 10.50.222.44 with SMTP id qj12mr18896360igc.48.1423507059068;
 Mon, 09 Feb 2015 10:37:39 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Mon, 9 Feb 2015 10:37:39 -0800 (PST)
In-Reply-To: <1423412045-15616-10-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263577>

On Sun, Feb 8, 2015 at 8:14 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> It makes no sense to delete a reference that is already known not to
> exist.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Reviewed-by: Stefan Beller <sbeller@google.com>
