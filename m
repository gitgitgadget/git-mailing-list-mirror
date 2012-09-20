From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Enable info/refs gzip decompression in HTTP client
Date: Wed, 19 Sep 2012 19:59:45 -0700
Message-ID: <CAJo=hJtUOQK8iYXa3zMm2c5NEF-6s=v4MHYWhxADohKmRrqe9Q@mail.gmail.com>
References: <1348096322-21426-1-git-send-email-spearce@spearce.org> <7vtxutcymr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 05:00:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEX02-0008Lp-P5
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 05:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056Ab2ITDAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 23:00:09 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:47560 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab2ITDAG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 23:00:06 -0400
Received: by qcro28 with SMTP id o28so1386006qcr.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 20:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=A0ZEKDe+uawZPejnn/wbIY1BPFGUZA4E4lDU/fXyb18=;
        b=bNmPr3zRKZWFpoOye6GgsenG1F+9tGCwNIkjCCJY0CA2h2PwTEu2InC707l+lvwo8R
         FaebJ7qmo5/X5c4cB1OTzkLEGd4nCkBOV7ywBzSjLrc4gc3McocHw5H+74TDmjN93Xux
         FSThzDyfJgstnC5UTf4fGDA1gfNrsk9+YoQx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=A0ZEKDe+uawZPejnn/wbIY1BPFGUZA4E4lDU/fXyb18=;
        b=X812Ga9hHSw1zYDXWyEqOdNETjyBlzQLv/q3EhSEeIZfuffVA9XijH4A+usn3yIBjy
         QtlS54LiUDeksUkuDI6RViBKRkRXXIfn3eoWiFsmuWvEI4Xzc3G3knIuC/kZbLn4Ya10
         1HCIQjtWA3Qwf3AMN8nZt8OUJgTD5mOXPqvhkr0iYnzRPEkj/OnyTugYXUuTWUrJstsf
         vn8y7jiidX3yFRf0+0lTzIX241dO/ImuL2wcJfBZ3Z2mlZVnT3I+ZEAUtoJUEI6K7kvD
         Z+cGqunMs65aiLnjRUlXbNXK+8cEIjHLRuiuSSoeplr5eILsoIPucLYNpFN/Txx3bAfL
         jvow==
Received: by 10.224.175.204 with SMTP id bb12mr1828564qab.14.1348110005400;
 Wed, 19 Sep 2012 20:00:05 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Wed, 19 Sep 2012 19:59:45 -0700 (PDT)
In-Reply-To: <7vtxutcymr.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQmZGFcDUmVY4jTh8rztOXYd4kAhasZj6gaPw9ymxDN5v8o2bz3MJpQzCQPUPh/v4+CqEPli
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206027>

On Wed, Sep 19, 2012 at 5:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> -> Accept-Encoding: deflate, gzip
>> +> Accept-Encoding: gzip
>
> ... was loss of "deflate" intended?  If so why?  Could you explain
> it in the log message?

Yes. I would add the following to the end of the commit message as a
new paragraph, please amend this for me:

--8<--
Only request gzip encoding from servers. Although deflate is
supported by libcurl, most servers have standardized on gzip
encoding for compression as that is what most browsers support.
Asking for deflate increases request sizes by a few bytes, but
is unlikely to ever be used by a server.
-->8--
