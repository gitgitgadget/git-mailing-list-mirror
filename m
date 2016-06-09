From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 4/6] send-email: create email parser subroutine
Date: Thu, 9 Jun 2016 02:51:30 -0400
Message-ID: <CAPig+cSn5LQ0OxDbg5y=dv16VC-jCaehnss_14mc34o95QbEpw@mail.gmail.com>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160608130142.29879-1-samuel.groot@grenoble-inp.org> <20160608130142.29879-5-samuel.groot@grenoble-inp.org>
 <xmqq8tyfmuk4.fsf@gitster.mtv.corp.google.com> <CAPig+cTO+-aATxyNBt2HtctH_ofgqEc8ik3OLSN+THVgu6dhKQ@mail.gmail.com>
 <fb7795c4-60db-94b3-a584-8fadd0440773@grenoble-inp.org> <CAPig+cQ5OKFTA8pEge=0e2RMT3ghmat-szw73aO_3WVW1=eAFQ@mail.gmail.com>
 <xmqqy46fjuzm.fsf@gitster.mtv.corp.google.com> <4c1dcf95-d8bb-4649-8980-fa947617b96e@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	tom.russello@grenoble-inp.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>, aaron@schrab.com,
	Eric Wong <e@80x24.org>
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 08:51:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAtoZ-00080g-GI
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 08:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933380AbcFIGve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 02:51:34 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36162 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933293AbcFIGvc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 02:51:32 -0400
Received: by mail-it0-f66.google.com with SMTP id h190so4052750ith.3
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 23:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=vDStiOH5d948EllLHGq8HCfWRMWFJ5JYIAbXMBhZB9c=;
        b=BXJkUv2eVZlzOXuFI3NMiuxxSp84n3d9ktjYo/RbNtnT7pJQMgSIlv0AyzjTG5g3v0
         s4iop/OrF2kqiu1o3bC63sKNO+qMTYkXnOf5FTPcgdHMd8oIiufkcqOg6tJVKG6skg/H
         JMi/mjWy1ZUUToMyUOKZg0hfcz6M5s6yc2nklqkp3HMziuvkySWJXFe5Mh23nBkTOxrb
         eEjesorNl9cs/7GT88lEogNIcEYTOEowhw08R/mFj4qIv1WRSrUUFyeZ84lueC+DgyrD
         Xy5jDYptw41SDMptPBP+A1EFVYysBJY6UPH3c9UDCbgfPXJ3WIIcVPNBRFyeEjV0Fsrp
         Qp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=vDStiOH5d948EllLHGq8HCfWRMWFJ5JYIAbXMBhZB9c=;
        b=GJbo8HagT5JoPM6BBujHr1zzV/39xOs5PfgenK4lryXkE0cn1yrmDFn9NagEbUzyYi
         YMYGJv5899SlFV1QEtHfdJW8Eddgosi/dW6drmW/YZpf06S19b0VhxDJ35pAaoCqJcCv
         SlQhWDsUZPjxv3ySOwQ4cIU2GVRlUM8pRzXpnF0ySDD+TiUHHdlECDEC1i8PCTy/nthZ
         Qx1QRb13rvYSnW1NClf5conzOOqT6Sjy8D09Zs7i09g19WPbU7+nvrDGhnnAZVrYTsYS
         mR6IfqLoQ/MFkiqdn0kEGxuiaViLIaUr656ChPA47gzvmFaZSOk0Dv9P+3tpVz4GeWV3
         6Y4w==
X-Gm-Message-State: ALyK8tIeXzW2J2R0/fEZ65lklCN3h6eAXgcMkuWoOvZNM8iRr3sQ28PKdbACi48jrOGH/th8QYWD6WJXbBJGug==
X-Received: by 10.36.55.15 with SMTP id r15mr15136205itr.73.1465455090989;
 Wed, 08 Jun 2016 23:51:30 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Wed, 8 Jun 2016 23:51:30 -0700 (PDT)
In-Reply-To: <4c1dcf95-d8bb-4649-8980-fa947617b96e@grenoble-inp.org>
X-Google-Sender-Auth: Q_9v5NQ80vDZPGXdD0O9Bltkn4A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296873>

On Wed, Jun 8, 2016 at 7:54 PM, Samuel GROOT
<samuel.groot@grenoble-inp.org> wrote:
> On 06/08/2016 10:17 PM, Junio C Hamano wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> An embedded CR probably shouldn't happen, but I'm not convinced that
>>> folding it out is a good idea. I would think that you'd want to
>>> preserve the header's value verbatim. If anything, I'd expect to see
>>> the regex tightened to:
>>>
>>>     s/\r?\n$//;
>>
>> Yes, that would be more sensible than silently removing \r in the
>> middle which _is_ a sign of something funny going on.
>
> s/\r?\n$// looks fine.
>
> Email::Simple library uses qr/\x0a\x0d|\x0d\x0a|\x0a|\x0d/ [1].
> [1] * http://cpansearch.perl.org/src/RJBS/Email-Simple-2.210/lib/Email/Simple.pm

You could certainly use s/\x0d?\x0a$// rather than s/\r?\n$// to be
really robust, but I doubt it matters much today. The reason for using
hex codes is that \r and \n will resolve to CR and LF in the local
character encoding, and those may not be 0x0d and 0x0a, respectively.
I believe the canonical example given in the Camel book was EBCIDIC in
which \r is 0x0d, but \n is 0x25, not 0x0a as it is in ASCII.
