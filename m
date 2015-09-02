From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v15 11/13] tag.c: use 'ref-filter' APIs
Date: Wed, 02 Sep 2015 08:10:09 -0700
Message-ID: <xmqq8u8oq2lq.fsf@gitster.mtv.corp.google.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-12-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 17:10:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZX9g6-00031l-3n
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 17:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbbIBPKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 11:10:16 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33978 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497AbbIBPKO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 11:10:14 -0400
Received: by padhy1 with SMTP id hy1so14627668pad.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 08:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=f3G34DuEPXTEMO/5DiSQDVUsJdRBBqhjgbg9UCqgaGE=;
        b=hHfoxZYgTaCp5Y5NuFT2q+k6tn31TTPNtaSldHdaap4grbqLnE5/oqM27NcMYYmmz+
         4lWOyZ9DBAsNCS16V2bHlmlxshAlLS6QPY/zsKSRou0eOeNhJ32MH8S4Yv/b1Ask/Pu+
         jZH5frY8kPyU1d+XbQmx4dAvU5LJXshLBR0k8/j0Wt2Mk+rT5hWezWEMNNjhXC1ieRxx
         jxRZ8UGyOhxv8sIi5kmsk9XjLU7hI6bs3TWSe1Ygn7cnk6vTUru9L8w/FEOGtx6NnX7/
         AM38IWTG3r+dJxtDybBmke9GrtQhf68jAxHEWp6Ls6c4/Qu1OZcmpe01+wqPGPIZUafG
         n9QQ==
X-Received: by 10.67.30.161 with SMTP id kf1mr56767328pad.89.1441206612304;
        Wed, 02 Sep 2015 08:10:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2414:9e5f:bc96:1638])
        by smtp.gmail.com with ESMTPSA id pf4sm22034296pdb.37.2015.09.02.08.10.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Sep 2015 08:10:10 -0700 (PDT)
In-Reply-To: <1441131994-13508-12-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Tue, 1 Sep 2015 23:56:32 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277095>

Karthik Nayak <karthik.188@gmail.com> writes:

> +	if (filter->lines)
> +		format = to_free = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) %%(contents:lines=%d)",
> +					   filter->lines);

I recall hearing that you were more in favor of

	"%(align:16)%(refname:short) %(end)%(contents:lines=4)"

somewhere in the earlier discussions?
