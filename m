From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv8 4/9] receive-pack.c: simplify execute_commands
Date: Tue, 30 Dec 2014 00:41:26 -0800
Message-ID: <CAGZ79kbthoUbeHEGUv4QSGwAsbLjEPhFFLgGMi++3iPqU5bvyQ@mail.gmail.com>
References: <1419907007-19387-1-git-send-email-sbeller@google.com>
	<1419907007-19387-5-git-send-email-sbeller@google.com>
	<CAPig+cT9JVkDvUUsbx9HW8HpakCb9SkoQf3LJZc4h3TQTt2ZXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 09:41:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5sMt-0006Bb-Mr
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 09:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbaL3Il1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 03:41:27 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:64518 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbaL3Il0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 03:41:26 -0500
Received: by mail-ig0-f173.google.com with SMTP id r2so12257152igi.6
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 00:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/r15otaXPCS3sjmuNhKhX/hlxYW9wQdM1y8kwNrxoYc=;
        b=XKlYzzjDw3a2cPpWld701yufzzB2yWQKbAb1CQ9UbUwU32wYdqmpZxO06YoUDN0yWd
         JUeHVy2sRL3kwM5bLw6S0QxYeYdgcn/P1jo6FYNBihkMgvg+w823SNzMxW7/ZE7meMGD
         30GjT6iyVBF8uCenkXS8ZjLklYIyKSNyjPb2quwudD3Z5EY4x8lTvMsSHWpHanKYkgMP
         1DOGS3KHoVDjSHyKieWcOy2L8gy6CV9jbbPUDaqixfYCTcEL9lJTKkSzgu/LegDLC4eJ
         Vm9h3ku0qHapqePR56EEf39t4mo85EAlG/1zMbFwPn38xnvNsUySaEYuzuKBJaESPhPp
         N9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/r15otaXPCS3sjmuNhKhX/hlxYW9wQdM1y8kwNrxoYc=;
        b=OY0VBim58BVVsLiN2sYgJCJHczPFwkjZB42UPEXiBhNuWH3If3keqZH7ijg9PfeUEn
         Rt/sxS8z5th++Lu0+yCYxc8bo57UFZCpoNiJZWam+Dzgw7lQCMhFTDYZ14H6wszVZtGs
         lZOynsHHb2jA8Ij0h6b2ORJNLxBiy4g1k4PtNSLEAWLYpyZqsDuikrGN83MqLKMT8bOq
         wZLkN25/AwzBPDohQrT6gvv0WTWYBS2PHJq9geNPI2ctLXOFqYIaWVZedvm/yxodVoNZ
         4g5/pKMXBJB6v4TGL+95FRW2YXu/zzsGrtLfWwjyTLVVO2OVlXq5xPRYzbm3bTd5o3KL
         sS9Q==
X-Gm-Message-State: ALoCoQkX9mRyX1VT7bBQwz0DF0GgZcMIxC5GD42Z89OlsuCcJUfWeFZ+FM9kiRTQXzuDr0PE9WIy
X-Received: by 10.43.82.72 with SMTP id ab8mr46739346icc.76.1419928886121;
 Tue, 30 Dec 2014 00:41:26 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Tue, 30 Dec 2014 00:41:26 -0800 (PST)
In-Reply-To: <CAPig+cT9JVkDvUUsbx9HW8HpakCb9SkoQf3LJZc4h3TQTt2ZXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261917>

reply to all instead of reply to Eric only.

On Mon, Dec 29, 2014 at 10:11 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> In v6, you considered this a fatal error in the atomic case, which
> caused the entire transaction to be rolled back. However, in this
> version, this error has no effect whatsoever on the atomic
> transaction, which is a rather significant behavioral departure. Which
> is correct? (This is a genuine question; not at all rhetorical.) If
> failing the entire transaction is the correct thing to do, then this
> is going to need some more work.

I don't know. in v6 I thought *any* error would stop and abort the atomic
commit. An atomic commit is either completely free of failures or it
doesn't work out.

However that warning doesn't seem to have any effect as of now
(apart from warning the user obviously), and is about the (highly
unlikely?) case of
a bug in git (or a provided helper script/hook?), I thought we can go
with it as well.
The transaction wen't through so all is fine. The thing the warning is
about is about
reachability checks for the shallow case, so I don't see why that
should fail the transaction.
