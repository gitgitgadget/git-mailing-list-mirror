From: Harry Jeffery <harry@exec64.co.uk>
Subject: Re: [PATCH] pretty-format: add append line-feed format specifier
Date: Tue, 09 Sep 2014 20:30:20 +0100
Message-ID: <540F554C.5010301@exec64.co.uk>
References: <540F426E.6080908@exec64.co.uk> <xmqqmwa8k3lg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 21:30:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRR7J-0001n0-3y
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 21:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbaIITaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 15:30:08 -0400
Received: from mail-we0-f180.google.com ([74.125.82.180]:43044 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbaIITaE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 15:30:04 -0400
Received: by mail-we0-f180.google.com with SMTP id t60so3146398wes.11
        for <git@vger.kernel.org>; Tue, 09 Sep 2014 12:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=bVhHp/U5jIttQMOfJg+NLeWyQuTz2nIONhoWLqcNcgA=;
        b=Ot0S9fNZWd5YCa0FwbZC/BPfGXbXFPnNYmJe0Tegk+ilAr+zTITZFuzt02VGXszcKE
         aOShaYS2YD1IAoS076BsPPaHQKDs6OEkDjgUs9055sidzTaNV87GW3+LmvWHp8QCE8hs
         uuFsqwJuOI0oDPK52C8yYFy4rtZ3hsCMNJf0XlwYGmPICCPw7brbFfJmpQ/S0LASGg1y
         1Ge3cK81vVpoGYhcZSd2jwjl8yxujoQFQS6ogq1dmXLGZVSCqP/OshYfveMGomQy8aBK
         3l1AKkEGBEREoRZS0ch3C8a5GZzeZMiKaWIFwUjmCquxmWTlcJp7T+edm4ZOl4BsOgUH
         SpRQ==
X-Gm-Message-State: ALoCoQmoPP9tEHVWfwfV9wMxE9w9fu3x8i0404XaQL5rsfEpDu+Ou5j2Y4HqRZrB1sp7Wk09e97K
X-Received: by 10.194.89.168 with SMTP id bp8mr44248949wjb.53.1410291001855;
        Tue, 09 Sep 2014 12:30:01 -0700 (PDT)
Received: from [192.168.0.14] (cpc69047-oxfd25-2-0-cust267.4-3.cable.virginm.net. [81.109.93.12])
        by mx.google.com with ESMTPSA id ew1sm15967070wjb.31.2014.09.09.12.30.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Sep 2014 12:30:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqqmwa8k3lg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256705>

On 09/09/14 20:15, Junio C Hamano wrote:
> Is this different from "%n%-d"?
>

Yes. "%n%-d" will place the newline before the expansion, not after.

log --decorate --pretty=format:"%n%-d%h\\ %t\\ [%cn]\\ %s"
---

  (HEAD, upstream/master, master)85f0837 c29da1d [Junio C Hamano] Start 
the post-2.1 cycle
  f655651 4027a43 [Junio C Hamano] Merge branch 'rs/strbuf-getcwd'
  51eeaea 1f4970c [Junio C Hamano] Merge branch 'ta/pretty-parse-config'
  4740891 8961621 [Junio C Hamano] Merge branch 'bc/archive-pax-header-mode'
---

log --decorate --pretty=format:"%_d%%h\\ %t\\ [%cn]\\ %s"
---
  (HEAD, upstream/master, master)
85f0837 c29da1d [Junio C Hamano] Start the post-2.1 cycle
f655651 4027a43 [Junio C Hamano] Merge branch 'rs/strbuf-getcwd'
51eeaea 1f4970c [Junio C Hamano] Merge branch 'ta/pretty-parse-config'
4740891 8961621 [Junio C Hamano] Merge branch 'bc/archive-pax-header-mode'
---

The latter is the output I've been trying to accomplish, and as far as I 
can tell, this patch is the only way to achieve it.

Well, you can do "%d%n" but that will put a blank line before every 
commit that doesn't have a ref.
