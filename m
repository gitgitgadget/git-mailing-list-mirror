From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH/RFC 0/7] Multiple simultaneously locked ref updates
Date: Thu, 29 Aug 2013 11:46:56 -0400
Message-ID: <521F6CF0.6040905@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <201308290932.18199.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Aug 29 17:48:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF4Sf-0006f8-AE
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 17:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650Ab3H2Psh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 11:48:37 -0400
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:35863 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753240Ab3H2Psg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 11:48:36 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]) (using TLSv1) by na3sys009aob108.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUh9tU+lRNeyxBWE+pGvYBmEYnVpfGd9a@postini.com; Thu, 29 Aug 2013 08:48:36 PDT
Received: by mail-ob0-f182.google.com with SMTP id wo10so660861obc.13
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 08:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=HoSNPZ85GT35DviRU6f0WRYzcy9nTilhG536b78X5RI=;
        b=Ce8HQdSTzZnLGoWvWtSAnnTyC4wLKWl4g2gvytL5FFVC1ayA4bl71yHbhPWHXtNiYI
         TGNtrwhzBwLI35KXljmrB5RSIxv8E3Xbqy+9hJrMQwl7iWaG1UiJ9mJ3tlUTE82SBuyj
         5wB8lYyfQUvGRxw1oL/aHnQheJIa/Gg2SRvDKt447t9AuHISkcfzAlm1dTE+ED+BmePk
         bNbvxxIzHXda7Cv+YaUrcOlnDcmoioXvz4TCHj4bdRBAgcDOk9lUFT9tm7bZSVmBMlpN
         dqOuDXoRnRAYqvD7pDCcTeI2xryTgx6M/iObUeEsPavWh4Mw3nl52Pksrcf/WciMa7EX
         CQMg==
X-Gm-Message-State: ALoCoQnS/YEzs1t3kEL5mDWmNqf6P6OYHFtMhku63qnFBeDsRC5ldYwEJMjcz2JxjbgJXW1oiV8XKt4/8xUopyecF8SIpbwR6dBjwGpnqGRHkUrjevdlnyMihsWWEAvJclHgJklOljqxViUFAKaYpPi9UiJh21qA1A==
X-Received: by 10.60.116.170 with SMTP id jx10mr378735oeb.98.1377791315467;
        Thu, 29 Aug 2013 08:48:35 -0700 (PDT)
X-Received: by 10.60.116.170 with SMTP id jx10mr378725oeb.98.1377791315350;
        Thu, 29 Aug 2013 08:48:35 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id d8sm21820497oeu.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 08:48:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <201308290932.18199.mfick@codeaurora.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233280>

On 08/29/2013 11:32 AM, Martin Fick wrote:
> On Thursday, August 29, 2013 08:11:48 am Brad King wrote:
>>
>>    fatal: Unable to create '....lock': File exists.
>>    If no other git process is currently running, this
>> probably means a git process crashed in this repository
>> earlier. Make sure no other git process is running and
>> remove the file manually to continue.
> 
> I don't believe git currently tries to do any form of stale 
> lock recovery since it is racy and unreliable (both single 
> server or on a multi-server shared repo),

Nor should it in this case.  I was saying that the front-end
needs to reject duplicate ref names from the stdin lines before
trying to lock the ref twice to avoid this message.  I'm asking
for a suggestion for existing data structure capabilities in
Git's source to efficiently detect the duplicate name.

-Brad
