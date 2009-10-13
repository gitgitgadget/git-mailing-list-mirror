From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v3 4/8] imap-send: fix compilation-error on Windows
Date: Tue, 13 Oct 2009 19:25:21 +0000
Message-ID: <1255461925-2244-5-git-send-email-kusmabite@gmail.com>
References: <1255461925-2244-1-git-send-email-kusmabite@gmail.com> <1255461925-2244-2-git-send-email-kusmabite@gmail.com> <1255461925-2244-3-git-send-email-kusmabite@gmail.com> <1255461925-2244-4-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Oct 13 21:26:47 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f143.google.com ([209.85.221.143])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxn0y-0006Yc-Cy
	for gcvm-msysgit@m.gmane.org; Tue, 13 Oct 2009 21:26:32 +0200
Received: by mail-qy0-f143.google.com with SMTP id 7so10658267qyk.15
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Oct 2009 12:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=SrfVfbguQJEYWi2+bzmY/13G4w7kWceLhNgMdW6khGY=;
        b=V2/pCAIBcNqgRboK914npOLBTPs5mwOpv/auilO4ZNKlLg57XI0NmzKjTpqLAISBTI
         zGANmdjblNel9FNy6wqDDLRURKH5y41oiJ6AHhQBZLScXpQtMbjIrANBBEEXp0UICD2C
         OgPmLqjlzjahUqca+ruK+v36UooUucHohQong=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=cbHlM9/1P5B9XFCATTa4gInkW6ZxuKgpQwe3SJ0CK9Yk/2pV2iph3CyFPpLgf8gAkR
         Lo+KPEXYBeaEvB9QG38PpSZKjpl/Cl2vyrZOp+7YCZhtkJQf6lCwBX+RgjekUkdc6AdR
         1/cSRT7+rsJXlpoxsfLr1lX/Ldd96Vm++jPAg=
Received: by 10.224.64.208 with SMTP id f16mr335547qai.13.1255461985690;
        Tue, 13 Oct 2009 12:26:25 -0700 (PDT)
Received: by 10.177.117.7 with SMTP id u7gr7398yqm.0;
	Tue, 13 Oct 2009 12:26:17 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.2.10 with SMTP id 10mr761159ebb.8.1255461975792; Tue, 13 Oct 2009 12:26:15 -0700 (PDT)
Received: by 10.210.2.10 with SMTP id 10mr761158ebb.8.1255461975767; Tue, 13 Oct 2009 12:26:15 -0700 (PDT)
Received: from mail-ew0-f206.google.com (mail-ew0-f206.google.com [209.85.219.206]) by gmr-mx.google.com with ESMTP id 13si331846ewy.2.2009.10.13.12.26.14; Tue, 13 Oct 2009 12:26:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.206 as permitted sender) client-ip=209.85.219.206;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.206 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by mail-ew0-f206.google.com with SMTP id 2so976523ewy.3 for <msysgit@googlegroups.com>; Tue, 13 Oct 2009 12:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references; bh=x4gCYw3KIlJRA5oJFDuhKMi0XRgQ/pkWPrPbi41wEyk=; b=pHJYQOfAMu10ZW7QyLDEUjH8ishUV3nC6Zuc6muNoPaUrqU0uTMn0zbqIFWSogklDR P67wTVEA3NnAZ+1keggRxThfF2fHP7rhtEsYxDbh3A9etNFQYV7V1nNmR4mB6xEcpvmF Mg27lzmu5Thhye0jk+cw9WtfTqFO0oayG4yN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=gEX6tKTDny59n74PU52Z+romy6E++bs68PggUeUESOqYqTBOczyU1TMtbHCEUn2a8y tRYbm8oLlaQ6RGMRRKLpKelgt4optt/O8yd6v+IFp/FgpgrNmxjhsV2GhMy3fv5X6CwE /GSUYwNHx/RO6Ty0Yybc/MYg04pWvLwD+t8OA=
Received: by 10.211.159.11 with SMTP id l11mr9132506ebo.78.1255461974444; Tue, 13 Oct 2009 12:26:14 -0700 (PDT)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12]) by mx.google.com with ESMTPS id 23sm4386224eya.26.2009.10.13.12.26.13 (version=TLSv1/SSLv3 cipher=RC4-MD5); Tue, 13 Oct 2009 12:26:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1255461925-2244-4-git-send-email-kusmabite@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130188>


mmsystem.h (included from windows.h) defines DRV_OK to 1. To avoid
an error due to DRV_OK redefenition, this patch undefines the old
definition (i.e the one from mmsystem.h) before defining DRV_OK.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 imap-send.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index dc3da98..07f86ce 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -94,6 +94,7 @@ struct msg_data {
 	unsigned int crlf:1;
 };
 
+#undef DRV_OK
 #define DRV_OK          0
 #define DRV_MSG_BAD     -1
 #define DRV_BOX_BAD     -2
-- 
1.6.4
