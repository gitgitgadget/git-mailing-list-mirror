From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/3] fetch: reduce duplicate in ref update status lines
Date: Sat, 4 Jun 2016 10:11:58 +0700
Message-ID: <CACsJy8DFE=NPB8+VfLFf_v719Rz8+at_daWyQ3jQUHYrB6TWZw@mail.gmail.com>
References: <20160522112019.26516-1-pclouds@gmail.com> <20160603110843.15434-1-pclouds@gmail.com>
 <20160603110843.15434-4-pclouds@gmail.com> <575199E7.7000503@xiplink.com>
 <xmqqh9dap5jk.fsf@gitster.mtv.corp.google.com> <5751E1C1.8080507@xiplink.com> <xmqqtwhangdn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 05:12:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9215-0000mb-RA
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 05:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbcFDDM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 23:12:29 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:32831 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbcFDDM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 23:12:29 -0400
Received: by mail-io0-f175.google.com with SMTP id t40so97373409ioi.0
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 20:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8Crx6HoN2TLbwzFzbp6/M88yjJ4ypS0Vrjp+vFXEhe0=;
        b=TJJkg4NHyojdQYvnwUCxzg8seQdnA3tYTIWnTyEkYQnX3+ytz8lro9UkcNAJBaNOHq
         ePIAc1VSV/ZQ/nVIB1vW/3NyWBScKehGmiqZMeDepWPj4eiJBgvynEAo3U5snbttYIj6
         sfXb7uQKWKmUffShtU3ZAtCcTyRbA4ERiLnJxdpu0vwjPvlTfamX2ls3qEv4RtPBubPv
         ohMGV9D0Vc9XIEx9+Kj/yuIzwYqkkrqo+GjULreegeBzoihe2CRkb+UlbB47D3S910hB
         7eus6ETqA/VbweM2n7hhDADeJZN/1B06hSQOrzyWy09k56/paMlcgylR45QoPEixQL+C
         XuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8Crx6HoN2TLbwzFzbp6/M88yjJ4ypS0Vrjp+vFXEhe0=;
        b=gBKtnYf+oFKViAbmM4+6W4n27afYD0X+hyF3NuSrI4pzKivyrD2gy/E9UHHmxwlF45
         WKyMISwnj8dW/ZBVXut2yjO/KNxIlKYuAtvJiCkK8NA60ePhBh0jl7ZUutw9FcaW85gS
         cvPMKqRMOVnz7O7EyFzPEh9SPXwZjmau/H5yTgBJDoq1Qabe2ACplffOG0atLE85zPk0
         97/xl9SXdxAiUxTDURd8bZw9otX8G2uOuceovfolTnxjMTI3PWaXG2zvmeiKW8K//3qf
         jrkfhsTB+q2zZd9DgKmjpmfnUt2toNR2cH9vcH09yFaRBVNOB+4J/8IaexFCBaw9ciwW
         fsLA==
X-Gm-Message-State: ALyK8tKAVS9jXUx3T+gbif+bQNPcmF/m/wxeyaGuvnsGs+vorvYHK7Z5O/1z9f64Ogo4ZV/JD464MtiiB39wnA==
X-Received: by 10.36.108.76 with SMTP id w73mr3695666itb.63.1465009948183;
 Fri, 03 Jun 2016 20:12:28 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Fri, 3 Jun 2016 20:11:58 -0700 (PDT)
In-Reply-To: <xmqqtwhangdn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296439>

On Sat, Jun 4, 2016 at 3:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> By punting on the effort to find a readable format that does not
> repeat the same info twice, we are sending a signal to the users
> that they cannot use a meaningful sentence as the name of a branch
> name; they need to stay within a relatively short (i.e. 1/4 of a
> line width) branch name, to avoid triggering this multi-line
> behaviour.

This is subjective because line length (or terminal width) varies. And
in the time where GUI and web interfaces are also used and preferred
by some, CLI users may not be able to do much with such a signal
(can't force everybody to suit you).
-- 
Duy
