From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH v2 7/8] update-ref: support multiple simultaneous updates
Date: Mon, 02 Sep 2013 13:21:06 -0400
Message-ID: <5224C902.6060408@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <cover.1377885441.git.brad.king@kitware.com> <ba564b6566b54d780a24355ca893294d814d8d24.1377885441.git.brad.king@kitware.com> <52223918.6040603@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Martin Fick <mfick@codeaurora.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 02 19:23:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGXq7-00015V-MN
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 19:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758705Ab3IBRW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 13:22:56 -0400
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:57869 "HELO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756322Ab3IBRWz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Sep 2013 13:22:55 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]) (using TLSv1) by na3sys009aob130.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUiTJb4fyGV5cRyMFsatTP+zLhkz/mNr5@postini.com; Mon, 02 Sep 2013 10:22:55 PDT
Received: by mail-ob0-f173.google.com with SMTP id ta17so4768577obb.18
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 10:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=FpkDPOk8dQosN6hSiTA4B+oglniXlpcE4YNqdKxuEgY=;
        b=MgwRYDt5L/RZX2ITz5oAmtT66sp4nstRF8+r+mUwTL1Y1ZpkS6cUXvs+j9EhVKAicX
         vekmbtOGWcOKzYjapRJi/+W0m0YxKPLFU/CVc18jJ/eHlt+FQXw023YOqkMUP5TJW9v6
         TwuFqqPQy5vCjE/ILOB2OfeylWu+MPDjbRBY9cjdUIEvBNwvwrmeqc2NzGzlQUqL7LjI
         +O02MOzTrq5FZKoEbRtV5d6qNpgEB9ewwJqaFcg6Z7Ys9gN8pInDmWrtePFkVvygE9qW
         QMu7f2E2wBmJBWI1PLUlPspWPKuYNViHt1Qxi6bj6Qrr2Ve/eIRd70h5frmvLwJ6h5iS
         acPw==
X-Gm-Message-State: ALoCoQkkEewJ4PS7NjeKDohvmq8TxOD+jXznJbsaws3U8rrStXXjWMGwd2TANJmlJlMmBGpdT2RCG1loJg/w0bb/JDxy71KKiGkSFSmpiuD11sSOctLyhZJvZNlzUYCTYt0n2bJpARqqB9R+OtfmcgNxJalER7d1qw==
X-Received: by 10.182.165.5 with SMTP id yu5mr17498986obb.93.1378142574672;
        Mon, 02 Sep 2013 10:22:54 -0700 (PDT)
X-Received: by 10.182.165.5 with SMTP id yu5mr17498981obb.93.1378142574578;
        Mon, 02 Sep 2013 10:22:54 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id s9sm13946073obu.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Sep 2013 10:22:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <52223918.6040603@alum.mit.edu>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233641>

On 08/31/2013 02:42 PM, Michael Haggerty wrote:
> On 08/30/2013 08:12 PM, Brad King wrote:
>> +If all <ref>s can be locked with matching <oldvalue>s
>> +simultaneously all modifications are performed.  Otherwise, no
> 
> Comma after "simultaneously".

Fixed.

> I agree with Junio that your quoting rules are peculiar.

I won't disagree.  That's why I asked for suggestions in the
original PATCH/RFC cover letter ;)

>> +	/* Allocate and zero-init a struct ref_update: */
> 
> Here you can use ARRAY_GROW().  See
> 
>     Documentation/technical/api-allocation-growing.txt

Fixed.

Thanks,
-Brad
