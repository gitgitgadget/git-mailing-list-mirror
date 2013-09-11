From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH v6 7/8] update-ref: support multiple simultaneous updates
Date: Wed, 11 Sep 2013 08:36:39 -0400
Message-ID: <523063D7.7000305@kitware.com>
References: <cover.1378732710.git.brad.king@kitware.com> <cover.1378773895.git.brad.king@kitware.com> <74c081c4004f3a8afb38ab15aff7d3178de4a1f8.1378773895.git.brad.king@kitware.com> <CAPig+cQ=PSQbF4+YfZC-Ps2Te47VNTRm_yDTVY48vGh4G2UFgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 14:39:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJjhV-0006Qz-39
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 14:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291Ab3IKMjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 08:39:11 -0400
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:60132 "HELO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752930Ab3IKMjI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Sep 2013 08:39:08 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]) (using TLSv1) by na3sys009aob129.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUjBkaycqbnrc0JC8exRl817wjf+v1TlW@postini.com; Wed, 11 Sep 2013 05:39:08 PDT
Received: by mail-ie0-f171.google.com with SMTP id 16so8048138iea.30
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 05:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ZEjtrWxj9Qa3wdN0wkB2WXy1PBHx/ps3PtdkJH8JJzk=;
        b=dmqbpvVGLo4UAFr++tQMZRp6uXf67GG12iTpp+LUKBZe1LVmHSDL9gVGIlE+Xi+52J
         AAu0uwc/Qu29/NEhKa71e6FdqsU6NYh/NaASHea1Sx4NOcSFLhhwcTkNjiHVjpbIv4Xc
         UE8Lck8kL8vdZXz/kWnfMfhggvt4SNJYJgnydSgTggzDKt/BkClVE2souS3AT3rmuRUA
         eIq80+ZP6RS13kV+rNR1gebZ9Po+I4TuoR4RnyiSNK+/lX+Yj5YNF+eSIOdYpDTDv9CL
         Ab5le2hYOpvs6K3fm0hP5cq9wOwA8KTZF8h5cp7GObBCN+a21ixdFvmVvnwBL/VX6wm/
         4b+g==
X-Gm-Message-State: ALoCoQmwT2tNslw0r1IUeOKeF/5G+nOvMe9vpd8MTeigryoi7QLLpeqdNUTOfVmRYGcXDH7Z96/EFrpOLWFF5qrxE0vXx3xVTjJ/W9XvFX6khXNrzyzsGVXdzLFP0xaJ6vtO/1Eu2TZZ7bDS+NDkSRm4oB8r4Yl96Q==
X-Received: by 10.50.67.46 with SMTP id k14mr322450igt.16.1378903129949;
        Wed, 11 Sep 2013 05:38:49 -0700 (PDT)
X-Received: by 10.50.67.46 with SMTP id k14mr322447igt.16.1378903129872;
        Wed, 11 Sep 2013 05:38:49 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id i11sm2967297igh.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Sep 2013 05:38:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <CAPig+cQ=PSQbF4+YfZC-Ps2Te47VNTRm_yDTVY48vGh4G2UFgQ@mail.gmail.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234562>

On 09/10/2013 06:51 PM, Eric Sunshine wrote:
> On Mon, Sep 9, 2013 at 8:57 PM, Brad King <brad.king@kitware.com> wrote:
>> +Use 40 "0" or the empty string to specify a zero value, except that
> 
> Did you want an 's' after the "0"?

The same description without 's' already appears in git-update-ref.txt
above this location in the existing documentation of the command-line
option behavior.  I see 0{40} in git-receive-pack.txt and also in
howto/update-hook-example.txt.  Perhaps a follow-up change can be made
to choose a consistent way to describe 40 0s.

-Brad
