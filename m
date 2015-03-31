From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCHv3 3/6] line-log.c: fix a memleak
Date: Mon, 30 Mar 2015 22:35:59 -0700
Message-ID: <551A323F.9030305@gmail.com>
References: <1427764931-27745-1-git-send-email-sbeller@google.com>	<1427764931-27745-4-git-send-email-sbeller@google.com> <xmqqsiclsqlz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sunshine@sunshineco.com, tr@thomasrast.ch
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 07:36:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcoqN-0007OY-Ui
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 07:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbbCaFgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 01:36:03 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35747 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbbCaFgC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 01:36:02 -0400
Received: by pddn5 with SMTP id n5so9294925pdd.2
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 22:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=xI7tQR+ENdHdPoQpuRIQVz8r5LT7J+63qYJl5Vv1TOQ=;
        b=SmfmbSrPY63ByE1NOz8DINVmoxCXr6Srle//mP4/zlWcxuhWLYMAXZp2tNovEl0UW7
         owFAbLc3U1//O1fXyldKjRAp7BfI76ax8v8+5yehVIuW+y9s0K0lL+gHr6Crk9bJf3cb
         +TvoA1hXBnNJvXQm7D9AOZUSyUD6oUcx4Tb3jel0TomCQ5An5ASazziYb4nYzMoodYMF
         h9z9ibcObFQh7a5R6Piv0zLW2eSaC9CGpDinkLrPYBjGPaiO/dav8r+KvDYoyE0Z/UNJ
         XwiYjUO5IZc3Q23+cQYPQjo1Ye/bYePVqw9784ZVCm+btYsbLk4hEdu8vT63eyLLTawL
         0fYA==
X-Received: by 10.70.9.131 with SMTP id z3mr39025621pda.156.1427780161970;
        Mon, 30 Mar 2015 22:36:01 -0700 (PDT)
Received: from [192.168.2.9] (c-76-102-52-132.hsd1.ca.comcast.net. [76.102.52.132])
        by mx.google.com with ESMTPSA id j5sm12491169pdo.60.2015.03.30.22.36.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2015 22:36:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqsiclsqlz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266514>

On 30.03.2015 22:06, Junio C Hamano wrote:
> If add-line-range does not take ownership of
> parent_range from us, shouldn't we be freeing it whether we called
> it or not???

In my understanding it does take ownership of it. (According to my code
review on friday)
