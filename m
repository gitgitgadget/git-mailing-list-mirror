From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH 03/26] t1400: Pass a legitimate <newvalue> to update command
Date: Mon, 10 Mar 2014 13:03:53 -0400
Message-ID: <531DF079.9050909@kitware.com>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu> <1394455603-2968-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 10 18:09:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN3i8-000145-Hs
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 18:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099AbaCJRJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 13:09:51 -0400
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:58292 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753520AbaCJRJu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 13:09:50 -0400
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Mar 2014 13:09:49 EDT
Received: from mail-ie0-f170.google.com ([209.85.223.170]) (using TLSv1) by na3sys009aob106.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUx3x3S/xUlC/YkTFgr/TgwiE32xCeM06@postini.com; Mon, 10 Mar 2014 10:09:50 PDT
Received: by mail-ie0-f170.google.com with SMTP id rd18so7619261iec.29
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 10:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=g2B0lTXuP2Z1KbiKjBA2MFzg+JWG1K/pCu9w8XlPzdk=;
        b=CLxJ+S17CWA94I3sG6feT/wHMgcEnFuzwG2l5Qmf0WOwHMSYVHKRzhfhvEc4Vhwyb9
         t6k7vydXUooGTiElaOpaaWoTSXhAJITkS7rtmVOQuPabLXkS1SigcLIRvlrWHpRJYqB0
         eCZJ6/C6w8YN4lKenLtfMo3qZxSqHwhS59UffxhTa23e6tGR0yG4rMH75WyfP0AKn7fJ
         qg3LR1dUZCS/chU1tnCQ4KQaG0pkTdALQIyNOCDYOLwM2paG2G1wtsUD52OU1cEIS6Rc
         rFrtAIlW8vLDrNsYpjPxBXhnNIP2Yp47+k9JP8MBIrfrgUCbOBPdCfi7MeTM/VzrvOPL
         8pvw==
X-Received: by 10.50.137.71 with SMTP id qg7mr18687053igb.38.1394470991639;
        Mon, 10 Mar 2014 10:03:11 -0700 (PDT)
X-Gm-Message-State: ALoCoQnKJr5upLl1Thn8DH+uzQne6Jv/U6R2rQhRdwGVorm8VQGK6OxkJc/XGEle/TtK/jy0mo5ZcpUT7FdflJoou6mGMF19i09bM6+bjLUsM9DQxaAYbOh/lEJiabICzKbTBk9VnneiEJ06AU2plmzrJFz+N2OiBA==
X-Received: by 10.50.137.71 with SMTP id qg7mr18687041igb.38.1394470991563;
        Mon, 10 Mar 2014 10:03:11 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id ro10sm37874100igb.6.2014.03.10.10.03.10
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Mar 2014 10:03:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1394455603-2968-4-git-send-email-mhagger@alum.mit.edu>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243773>

On 03/10/2014 08:46 AM, Michael Haggerty wrote:
> This test is trying to test a few ways to delete references using "git
> update-ref -z --stdin".  The third line passed in is
> 
>     update SP /refs/heads/c NUL NUL <sha1> NUL
> 
> , which is not a correct way to delete a reference according to the
> documentation (the new value should be zeros, not empty).  Pass zeros
> instead as the new value to test the code correctly.

In my original work on this feature, an empty <newvalue> is allowed.
Since newvalue is not optional an empty value can be treated as zero.
The relevant documentation is:

 update::
         Set <ref> to <newvalue> after verifying <oldvalue>, if given.
         Specify a zero <newvalue> to ensure the ref does not exist

 ...

 Use 40 "0" or the empty string to specify a zero value, except that
 with `-z` an empty <oldvalue> is considered missing.

The two together say that <newvalue> can be the empty string instead
of a literal zero.

-Brad
