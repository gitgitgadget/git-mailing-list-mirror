From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/2] nd/slim-index-pack-memory-usage updates
Date: Thu, 26 Feb 2015 17:52:06 +0700
Message-ID: <1424947928-19396-1-git-send-email-pclouds@gmail.com>
References: <1424397488-22169-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, msporleder@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 11:52:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQw2y-0004Sv-EF
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 11:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539AbbBZKv4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Feb 2015 05:51:56 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34517 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbbBZKvy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 05:51:54 -0500
Received: by pdjg10 with SMTP id g10so12256249pdj.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2015 02:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Dp9pVpvLQPstAmj5nrUPhDkyRyvFnI7eLW6/j3sMXz4=;
        b=ejeH2G/n+MuivwcHozyggtKIBWbAxlD4d+EhlRw3uXwcqL2wahFU0M4ANXVrrHtTht
         Jvjhe8j0biIby5VwDoxxptBnwZHwPbiSVXdASe+oCpEMpRtjm0bUCWxSV0LWSmIMvmAy
         HZYuI0RGcCxgrPwDK5+sn+VLCPZ4CpinhRAAyJWzr9UPExMslZYemYjLixhLVXwSLTGu
         mTMqNlKqDze7r8wbqsXfpxoOFlZF/EPGGuiSRGKYnjeKu0+WMj9xK2YUdq5gr3oe74IB
         G9UJE2WhcmAot0IXjunVqBenG08KNTW+1tdhdzqQVo79CySyxZc3jMeVVjW9mBjsHtOW
         RNOQ==
X-Received: by 10.66.219.130 with SMTP id po2mr13613736pac.98.1424947913510;
        Thu, 26 Feb 2015 02:51:53 -0800 (PST)
Received: from lanh ([115.73.213.171])
        by mx.google.com with ESMTPSA id xx7sm659607pab.21.2015.02.26.02.51.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2015 02:51:52 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 26 Feb 2015 17:52:18 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1424397488-22169-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264429>

This fixes the "signed char" bug in 1/2: "char" alone could be either
signed or unsigned but we do need signed char.

One point to clang for detecting "obj->real_type !=3D OBJ_BAD" on ARM
where real_type becomes unsigned char and OBJ_BAD is -1. gcc just
keeps quiet..

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  index-pack: reduce object_entry size to save memory
  index-pack: kill union delta_base to save memory

 builtin/index-pack.c | 290 +++++++++++++++++++++++++++++++------------=
--------
 1 file changed, 179 insertions(+), 111 deletions(-)

--=20
2.3.0.rc1.137.g477eb31
