From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 3/6] bisect: use refs infrastructure for BISECT_START
Date: Thu, 25 Jun 2015 20:22:53 -0400
Organization: Twitter
Message-ID: <1435278173.7900.27.camel@twopensource.com>
References: <1435265110-6414-1-git-send-email-dturner@twopensource.com>
	 <1435265110-6414-3-git-send-email-dturner@twopensource.com>
	 <xmqq616by0h3.fsf@gitster.dls.corp.google.com>
	 <1435274490.7900.19.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 02:23:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8HQ6-0007jK-0S
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 02:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbbFZAW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 20:22:58 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35850 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbFZAW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 20:22:56 -0400
Received: by iecvh10 with SMTP id vh10so65666311iec.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 17:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=Ir4ZFvBc5JlySMphwQJX17h/CuYYaUdM7zX4xuk8cec=;
        b=IZdfiEeob2WrOqUfV48GcjP34z5V3nvKqe5+OJYsyyUNGsdhFW41YrqWHLLSiLZkar
         24P//Fl93kOceMbFXKuTmJlDqLYxb5eh85kLawMP1H8nO5Ii1lBicPScAtHuvCFa17su
         rbki53DqjIgHFujqlIjzOZROmNcod2AdPIuRLtLUiJVLkCNWDxIr3lzcfYppzxPuLxNF
         ktAynw0Zc6OfSgIJuKhlfJuBc3FOC+Eje4EQzq2wb0oD2anHfTH5FuRM52adrWTqwRC9
         6mnkBPfE7UqnrYDXfQ3nKKOWVDq6WEaF2cy3QAMSdm3vvECArlI64rcP2FKjZ9TKUzcf
         58kQ==
X-Gm-Message-State: ALoCoQnTAlQmxug0nfJPiQckmJduN6+GEalY06tzhLh/Y3ePzG74PKnaSWwC/UuX+4LSxERxbX32
X-Received: by 10.50.61.241 with SMTP id t17mr385555igr.34.1435278176098;
        Thu, 25 Jun 2015 17:22:56 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id p8sm4426504iga.13.2015.06.25.17.22.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2015 17:22:54 -0700 (PDT)
In-Reply-To: <1435274490.7900.19.camel@twopensource.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272746>

On Thu, 2015-06-25 at 19:21 -0400, David Turner wrote:
> On Thu, 2015-06-25 at 13:52 -0700, Junio C Hamano wrote:
> > David Turner <dturner@twopensource.com> writes:
> > 
> > > This ref needs to go through the refs backend, since some code assumes
> > > that it can be written and read as a ref.
> > 
> > And the reason why BISECT_HEAD cannot be treated as a ref, but must
> > be treated as a file under $GIT_DIR, is...?
> 
> After running some tests on the long version of the series, we can and
> should move it into the backend; will add a patch to the next reroll

Actually, I've looked into this further. BISECT_START isn't a ref
because it contains the ref name that the bisection started from (not a
symbolic ref).  BISECT_HEAD is a ref.  Will fix.
