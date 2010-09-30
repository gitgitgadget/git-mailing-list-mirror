From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC PATCH 3/3] grep: add support for grepping in submodules
Date: Thu, 30 Sep 2010 09:48:34 -0700
Message-ID: <4CA4BF62.3030905@gmail.com>
References: <1285792134-26339-1-git-send-email-judge.packham@gmail.com> <1285792134-26339-4-git-send-email-judge.packham@gmail.com> <4CA3BBD7.3090006@web.de> <4CA3C569.4020309@gmail.com> <4CA4738A.9040503@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 30 18:48:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1MIz-0000F0-L2
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 18:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231Ab0I3QsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 12:48:18 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40309 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932227Ab0I3QsR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 12:48:17 -0400
Received: by pwj5 with SMTP id 5so340857pwj.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 09:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=AT+AY1BZjP/x8NbwlwziOb/dPE3R/ZZHYxgdw9Z3cX8=;
        b=QScOqG4M8kylxL2JU5+PRxnhYJBBzUoTmLXBh8gpx2aSqhOUKc0syGFmo5m5QVkWYg
         /AI1TN+OAmb0VYjAqcs/+sREkz8+KGCTktI92pkUf8V/CxlbDZLlC6a/tIYq5EhK6ZAn
         A4ZUsGyV95acojJSqYitl0vA5ntvsSBd9IeYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=tkfAr++9B4Jm77/PsUV+1+YY6ab1pz2V9f2l9VIjAOxHsTVeLdiz5VJpR2W/JYkVYu
         p7A8i5nyy17wteCEWajazcav+8x/rZb2hAIYuLf+neV+l9ErmisnTom+NkNJlBz6Zd7Z
         46aiS6fGw9VFgB+AHYOYW4RQZ4CcMJn9U3wu0=
Received: by 10.114.52.8 with SMTP id z8mr4618331waz.140.1285865296740;
        Thu, 30 Sep 2010 09:48:16 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id q6sm79430waj.22.2010.09.30.09.48.14
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 09:48:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <4CA4738A.9040503@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157689>

On 30/09/10 04:24, Jens Lehmann wrote:
> Am 30.09.2010 01:02, schrieb Chris Packham:
>> Yeah this is the part I was struggling with a little. It would be easy
>> to save argv before any option processing but I wondered if that would
>> be frowned upon as an overhead for non-submodule usages.
> 
> Yup, but as you are only copying a pointer array the overhead is very
> small. And if the code gets much easier that way (as I would expect)
> that price is well paid.

With the talk of translating superproject --index into submodule SHA-1,
re-formatting pathspecs and passing the superproject ref-name. It sounds
like making a copy of argv is not going to be that useful. If we did
copy it we'd have to scan it for the things we don't want passed to the
submodule grep.
