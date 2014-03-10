From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH 13/26] update-ref --stdin: Simplify error messages for
 missing oldvalues
Date: Mon, 10 Mar 2014 13:12:14 -0400
Message-ID: <531DF26E.50806@kitware.com>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu> <1394455603-2968-14-git-send-email-mhagger@alum.mit.edu> <531DF195.7020304@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 10 18:12:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN3kQ-0003e8-Qp
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 18:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320AbaCJRL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 13:11:57 -0400
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:36555 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754286AbaCJRLu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 13:11:50 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]) (using TLSv1) by na3sys009aob108.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUx3yVQz1/uCZK1bk/cJgNaFe3cxv3t1Q@postini.com; Mon, 10 Mar 2014 10:11:50 PDT
Received: by mail-ob0-f175.google.com with SMTP id uy5so7253663obc.20
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 10:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=/S1t2mxiFprZzJqPavw7wSO2cOY/Uqkrd42cGt+RB/Y=;
        b=NXzHIYiGis+PSJuDzU/wAxvI+wVJqBPZ041TotlJ1GeqGF0yQFNG5X4FfO+wKEePll
         MbNJiuAgkHqfNJafw6kvMURlOKRDVa43LQTWXdxOxijgw+BFzrDK9DK4ZBjotAkP9wUO
         uQQPhqFO8ka8RaIqoN12wJ2q8YHbqsyd/FrHCh8cVWpWSclS6C68C292bC3EMgs5zeQq
         eas9EV1Ar+DQ7xeE099Tr7c4YFLQOyRDKncn/EjKCyeZpzid9/1fsH3Ndh43dJ8Gyk/W
         7g1mIyzrZR6XZUEVMf89pqQxhY8Np6BACAvoVuAaTholDsY3H3qZdDRY9FwmxEKKSUw4
         IjZg==
X-Gm-Message-State: ALoCoQnflmvA9PI7iUUqDERG63qEniW80NcEGL1EKXukEQ4yH/baKPq8kgFhhPBmyRiCupD/cCK77ZrsoE/lKdgat/1EViMA4J9pwJz0UWhFL1jffQhdzUShvj3F0yASOQ/CIWQ09HgrjAlVlY2QN8G+jRUIzGM+9A==
X-Received: by 10.60.131.141 with SMTP id om13mr1424915oeb.68.1394471492928;
        Mon, 10 Mar 2014 10:11:32 -0700 (PDT)
X-Received: by 10.60.131.141 with SMTP id om13mr1424910oeb.68.1394471492838;
        Mon, 10 Mar 2014 10:11:32 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id lh7sm110426641oeb.6.2014.03.10.10.11.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Mar 2014 10:11:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <531DF195.7020304@kitware.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243774>

On 03/10/2014 01:08 PM, Brad King wrote:
>> -		die("update %s missing [<oldvalue>] NUL", update->ref_name);
>> +		die("update %s missing <oldvalue>", update->ref_name);
> 
> The reason for the original wording is that the <oldvalue> is indeed
> optional.  This can only occur at end-of-input, and it is actually the
> *NUL* that is missing because an empty old value can be specified to
> mean that it it intentionally missing.

I see a following patch makes the wording even clearer about
unexpected end of input, so ignore my previous review.

-Brad
