From: Stefan Beller <sbeller@google.com>
Subject: Re: Segfault in the attr stack
Date: Wed, 1 Jun 2016 15:11:49 -0700
Message-ID: <CAGZ79kbSKgS42nAShsK3JV78geam3k84=ipWRx7vbRODuHcmcA@mail.gmail.com>
References: <CAGZ79ka_4vZfNhgOyMeFKdossO-S5Q7RVnvEzB8YAJNc1YQ+uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 02 00:12:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8EMu-0006PE-AK
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 00:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbcFAWLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 18:11:51 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36558 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbcFAWLv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 18:11:51 -0400
Received: by mail-qk0-f180.google.com with SMTP id i187so22849416qkd.3
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 15:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=7pj3xFHi7vvknWogXxOcEgqoDHQQPP+QIGYXpp7bp3Y=;
        b=k+gST7HRkT+wp4teNzqHJwlhrtIBY3WqPaxyTsw6YA65LbFPUUbB72FA6qPfrPaMjA
         OMLPoJln71O5Dik+uNm3tMFa6R4/P8r2gacKuf8TdsGTQx6qxPxB6GNHNPMrOhL6n5b2
         wZHzJC8NlB95YykJaoI4Zif+jZtzN6DTCrPj8kXSWq1kojb8yBfM1d9w2u2JGnSC0bnU
         ZtBKdhX5XETToF2/egTkhbnykzrid/A5ODXb3ZeV8EeEuiGMFePUWtBtScE/yEk9QWJk
         ZhDV6QYjE1oGO0MXxxno8QMXcz4uCwuB/wMT45l1st/mA903UIdgugWD0DxI8A/MiuU9
         gG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=7pj3xFHi7vvknWogXxOcEgqoDHQQPP+QIGYXpp7bp3Y=;
        b=dwXk/ch02DT8ZxuRLOwyPmVm4/fY2jHyphrNuyPVYe+LGqjXWqLcsZuCNo/BvE2fL4
         xRHXgPYeUzSCInU131dyOReugqKe8cxpd84RNqI/diQcFEtRGIdBnbdRiyHut/M/4LVX
         Aqi31fQYUqQgyPY7YuB6/WVxEdbsxm5EnzJe5K8Wioyhwlfy00PJS9r2dTb5fpfOATab
         ZmqxM8z3tNlXDb/0THvRLW8RRiFpjWUAJ42IOhFlhDBTVjdDZj8m4Vcfm/HXuO1BP8Hw
         D5VRst0ffargaKHRdwJhHZIerjS6+A+G9uLy1yH02ragbemgwDT60auJV3ZkdPr3w0Ye
         7BUw==
X-Gm-Message-State: ALyK8tKdcHQ32MiukgFzYvlvFGdVp1FiKrsB9coLJ2axO2gPdKkdowgVj7+ZdzzQ1Yh2ctr3Hshv2ACClAh/ixVj
X-Received: by 10.55.10.130 with SMTP id 124mr40668278qkk.91.1464819110071;
 Wed, 01 Jun 2016 15:11:50 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Wed, 1 Jun 2016 15:11:49 -0700 (PDT)
In-Reply-To: <CAGZ79ka_4vZfNhgOyMeFKdossO-S5Q7RVnvEzB8YAJNc1YQ+uQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296171>

This can be reproduced on sb/pathspec-label in git.git as well.

The key difference I notice is `git ls-files` works perfectly (e.g. in
the tests)
while `git status` fails.
