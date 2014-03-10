From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH 13/26] update-ref --stdin: Simplify error messages for
 missing oldvalues
Date: Mon, 10 Mar 2014 13:08:37 -0400
Message-ID: <531DF195.7020304@kitware.com>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu> <1394455603-2968-14-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 10 18:16:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN3ol-0008Ja-1m
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 18:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbaCJRQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 13:16:42 -0400
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:37468 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752880AbaCJRQm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 13:16:42 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]) (using TLSv1) by na3sys009aob111.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUx3za8s4F3Cn8tKM0KamNStaS1Scvcm0@postini.com; Mon, 10 Mar 2014 10:16:41 PDT
Received: by mail-ie0-f181.google.com with SMTP id tp5so7538953ieb.40
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 10:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=IiwRR3R6vLd1FPe/VhulA4BnDPutxVXyHWc1zIGeqCg=;
        b=O1VMQ7Uf8SNlMmKc2WqLlD/F0YoWTt1+OXv/x8vvkUi2tZr+ItVIDc7eh/u9cE7I0N
         kazvWow5jgQ8ol7qNr5TTswsDzzeSxuQrxm4YQ/5L/P6QzS0/ykjJsUS0aH01/Vgx46w
         RNjNZrzcEVMIoPgUOzZa8/fAFSoth/vcqmgEZdHfMNB8LZiSR6dDYdJ8asNO/zVaxeg8
         ti88FDsY4cB65mmIfk/wJwSTD95oWhk16wkX+8CP2iLMJzdFWhJ1AFAPkk0IvnkPOGwY
         qTGghBy1ld241yydn1prAiktk51ahQ80cuuInHLwQxhL41ZLfLNkSrhOIRhT6KLDB+GC
         kngQ==
X-Received: by 10.43.18.135 with SMTP id qg7mr28475181icb.5.1394471280479;
        Mon, 10 Mar 2014 10:08:00 -0700 (PDT)
X-Gm-Message-State: ALoCoQkU8FMgnHEvX83zZm3U8e2YWk5U8KiX1nTNhS1bGlcCutWFVfV1AsiR88nPzxkUcGka7Q7cwuxMVpdxt5cycJsakk0+lJzgrMNidMmCEX4W6O8ZgWM19c/f0O/s3gTUAwoE443tWWrElb6x6fpXAtOvCctG+A==
X-Received: by 10.43.18.135 with SMTP id qg7mr28475170icb.5.1394471280409;
        Mon, 10 Mar 2014 10:08:00 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id sc8sm37900274igb.0.2014.03.10.10.07.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Mar 2014 10:07:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1394455603-2968-14-git-send-email-mhagger@alum.mit.edu>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243775>

On 03/10/2014 08:46 AM, Michael Haggerty wrote:
> Instead of, for example,
> 
>     fatal: update refs/heads/master missing [<oldvalue>] NUL
> 
> emit
> 
>     fatal: update refs/heads/master missing <oldvalue>
[snip]
> -		die("update %s missing [<oldvalue>] NUL", update->ref_name);
> +		die("update %s missing <oldvalue>", update->ref_name);

The reason for the original wording is that the <oldvalue> is indeed
optional.  This can only occur at end-of-input, and it is actually the
*NUL* that is missing because an empty old value can be specified to
mean that it it intentionally missing.

-Brad
