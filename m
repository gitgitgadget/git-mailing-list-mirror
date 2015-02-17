From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 0/3] request-pull: do something if $3 is passed
Date: Tue, 17 Feb 2015 21:53:21 +0100
Message-ID: <54E3AA41.5070209@gnu.org>
References: <1424110568-29479-1-git-send-email-bonzini@gnu.org>	<xmqqiof163kk.fsf@gitster.dls.corp.google.com>	<54E31405.5040502@gnu.org>	<xmqqvbj01fbz.fsf@gitster.dls.corp.google.com>	<54E3A5E2.6060806@gnu.org> <CA+55aFw_pKtraqwMMsqsYgF=ikShH=6ybtb7+QPr8r=77kmoVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 21:53:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNp99-0003GA-B7
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 21:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbbBQUx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 15:53:27 -0500
Received: from mail-wi0-f179.google.com ([209.85.212.179]:57440 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbbBQUx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 15:53:26 -0500
Received: by mail-wi0-f179.google.com with SMTP id hi2so36891710wib.0
        for <git@vger.kernel.org>; Tue, 17 Feb 2015 12:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=5VKyZAb8S/k84U3hepnJ2ZbRNao/TDSBzmWqN+Qvo4I=;
        b=cw8tRysRlh5jB3pl1l8n1voI48EYb94WULTkx7SksPkk9wmVA4EcA/xh/fF1GHIncW
         YcpH4NvwceZpbptyUTCGsnG+mVU4BcwKVt1UYdKhIFRkM0fxdLQ5QS+i8tSKq107oLJm
         XlSCMVHcBqoomjIzKvf2vPWPTD/OWPE12bp1Uly/+JZXroDYFybcMiI406rJrdxmC/60
         f5zDsYI8OFfBmopFJSPZzmWkNg7s7ThlfFi3ODn3Q5Hpn8tGVDl6ZXLdg4Syr910w5dR
         0kjGsigy6ipI0NkLVSm1Q1dl3f9a/J19Zo7VdsaDaPU7Zfu9JLejbbrfxpHuy2Sj63De
         ig9Q==
X-Received: by 10.180.206.98 with SMTP id ln2mr50299545wic.94.1424206405444;
        Tue, 17 Feb 2015 12:53:25 -0800 (PST)
Received: from [192.168.10.150] (net-93-66-73-217.cust.vodafonedsl.it. [93.66.73.217])
        by mx.google.com with ESMTPSA id k6sm21837829wia.6.2015.02.17.12.53.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Feb 2015 12:53:24 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <CA+55aFw_pKtraqwMMsqsYgF=ikShH=6ybtb7+QPr8r=77kmoVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263983>



On 17/02/2015 21:42, Linus Torvalds wrote:
>   "when $3 is not passed git will try to use "HEAD" as the default but
> it cannot be resolved to a tag, neither locally (patch 2) nor remotely
> (patch 3)"
> 
> which makes absolutely no sense.

Indeed, that's why I wrote patches even though I did find the patches
that you wrote for 2.0.

Without $3, git tries to do things that make no sense like "git show-ref
--heads --tags HEAD"; or that make little sense when requesting a pull,
like looking for HEAD in the output of "git ls-remote".  But from the
release notes of 2.0 it looks like it's intended and the script is just
taking shortcuts.

> HEAD is not a tag. Never has been, never will be. If you want me to
> pull a tag, then you damn well should say what tag you want, not just
> randomly say HEAD.

Ok, in 1.9.x I used to not say anything; if the new workflow is to
always specify a tag, that's okay.

> So what is it you want to do? At no point is "HEAD should resolve as a
> tag" sensible.

I wanted git to find the matching tag on the remote side when I use "git
request-pull origin/master URL" with no third parameter, since I never
request pulls except with a single signed tag.  But I'll adjust my aliases.

Paolo
