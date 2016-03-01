From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: [PATCH v2] builtin/receive-pack.c: use parse_options API
Date: Wed, 2 Mar 2016 02:01:09 +0530
Message-ID: <56D5FC0D.7080006@gmail.com>
References: <1456846560-9223-1-git-send-email-tigerkid001@gmail.com>
 <1456863661-22783-1-git-send-email-tigerkid001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: matthieu.moy@grenoble-inp.fr, sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 21:31:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaqwx-0000TW-3O
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 21:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbcCAUbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 15:31:14 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36194 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbcCAUbN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 15:31:13 -0500
Received: by mail-pf0-f195.google.com with SMTP id q129so5281196pfb.3
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 12:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=e6k2BBVnw/GI7e6p2zm/D5SMXL3+ERfE8ORxdX6/cJ0=;
        b=WKeABZ+EGIAilEriKUNVoOswh/qIViigXG5Z36qbLt5gDv2z4o/Em63l8Em7sE7NPh
         tRadppAEMVgLg3OQO8iHW6ZjxlqmyRU9NcgmJiUejwShvMEPqGrSyPnAhmS8+jXGiwej
         GoRE6y/u8rAwMl/0SEw7TjQYRXiLPy29To2nNYO7XrKPM4EmEARNkAW/VtQlNm7wrj1+
         DeGB3s58IBmQWlZXYuRWORzwBDvvIA4vfs5VE68UwFR82CoHsbKWaI1PQFXCEr5/kD7w
         ynFkO+NF34qKf/fghT/BxMCk/UyST3WIVmazMm5WQe7BeEZbp7yaz6i1Hcqq6RY2UOQ2
         k9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:subject:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=e6k2BBVnw/GI7e6p2zm/D5SMXL3+ERfE8ORxdX6/cJ0=;
        b=blZ72Wnz+UjjeMRjB10s0im2RRtW8rn4ghwWGbXOfbB91EuWttcIZcMVPa/YWzDUBt
         l8q+domkvnwSSMPJm15wkSeHn5PiRyJFWEEUyuEM+30O2YGwPeqTlUcBR/QlErV+RiOt
         aHq1cVbKoIl2wc1Za/cy0w0LLmUBAjxgw1PhDfKorAGwbCh3o34CqfmYNGFXLf4J2fUS
         bZwy20tF8QBndsz8/jOKr9VlTYR3ZvWa5fFxyJClZjLEUKu1t8mprwe00r364Wz60cPY
         J2raGnMmj51l8B/Pe5pSf83EJFx+d9vbdqjqeJsD8f7X3lhtqC2NWL3Lrol1620LhBl+
         dVsw==
X-Gm-Message-State: AD7BkJIyKS625dp5XK6ebjVRjZmdSu+sECpE95MaaDrv7U1K3jGa8b7atgiGKZLYUf9vUw==
X-Received: by 10.98.74.202 with SMTP id c71mr33132932pfj.25.1456864273297;
        Tue, 01 Mar 2016 12:31:13 -0800 (PST)
Received: from [192.168.1.10] ([182.68.185.50])
        by smtp.gmail.com with ESMTPSA id kw10sm47639829pab.0.2016.03.01.12.31.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Mar 2016 12:31:12 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <1456863661-22783-1-git-send-email-tigerkid001@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288061>

> Starting from here, the patch is a bit painful to read because the diff
> heuristics grouped hunks in a strange way. You may try "git format-patch
> --patience" or --minimal or --histogram to see if it gives a better
> result. The final commit would be the same, but it may make review
> easier.


I tried using the other algorithms, but results were same for all.


Regards,
Sidhant Sharma [:tk]
