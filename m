From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2013, #02; Fri, 6)
Date: Wed, 18 Dec 2013 15:05:04 +0100
Message-ID: <52B1AB90.1080800@gmail.com>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com> <52A37D70.3090400@gmail.com> <87fvq41esw.fsf@thomasrast.ch> <52A3A1F5.3080906@gmail.com> <87lhzvhceb.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098> <52A5CDB0.2020206@gmail.com> <20131209200820.GU29959@google.com> <52A64FE9.5010004@gmail.com> <20131209234500.GY29959@google.com> <52B19EBC.50609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 15:05:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtHkP-0006PG-J1
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 15:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482Ab3LROFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 09:05:06 -0500
Received: from mail-ee0-f47.google.com ([74.125.83.47]:61787 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725Ab3LROFE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 09:05:04 -0500
Received: by mail-ee0-f47.google.com with SMTP id e51so2985597eek.6
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 06:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9SoRXlPmtxu83d9QSQLRObgp1FsyYlHeuTa3ossbKrU=;
        b=Y3WJ3Im3LLpK4txUZzEqo7L8MTPgXnZPXc1M8IR0wuc7Cax7C0xVbcwRPHCy5WmrEG
         eUD6qEeCnq7gK5rlqnbn9/PZYMEiJk5qEqQQo0NAP0jMLjdEkMW/1dc497sdWK4g1qmJ
         o1Vyy1NR+1Fmp2yEPHRpDVy+kcFfozekUL7D3+s+SIs2hW9tYHlOakyV+anVnAcL3U61
         iG0D4boG3BwJu/4ZKPcmLqMK87v2YJmZndx7i2DX4eY+5rBc6CLL1FEE/+iXf7lpa7HX
         SFP381b/flBm57XQ7ViC0ayCbeg7i3YFUF/J+GEPXdY8xXLJPlcTzpVurQDGCyT5G3kn
         UvYw==
X-Received: by 10.14.174.129 with SMTP id x1mr29318339eel.19.1387375503957;
        Wed, 18 Dec 2013 06:05:03 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id h3sm305857eem.15.2013.12.18.06.05.02
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 06:05:03 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <52B19EBC.50609@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239433>

Am 18.12.2013 14:10, schrieb Karsten Blees:
> +				printf("sizeof(pointer+int) (%u) is not a "
> +				       "multiple of sizeof(pointer) (%u)!\n",
> +				       sizeof(struct pointer_int),
> +				       sizeof(void *));

Should be:
-				       sizeof(struct pointer_int),
-				       sizeof(void *));
+				       (unsigned) sizeof(struct pointer_int),
+				       (unsigned) sizeof(void *));

(sizeof() is 'unsigned int' on 32-bit and 'long unsigned int' on 64-bit; without the cast, "%u" produces warnings on 64-bit and "%lu" on 32-bit...)
