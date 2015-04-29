From: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v9 0/5] cat-file: teach cat-file a '--allow-unkown-type' option
Date: Wed, 29 Apr 2015 18:20:31 +0530
Message-ID: <5540D397.8020104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 29 14:50:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnRRq-0002U1-9w
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 14:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422979AbbD2Muh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 08:50:37 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36787 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422855AbbD2Mug (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 08:50:36 -0400
Received: by pdea3 with SMTP id a3so27431664pde.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 05:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=JurgquvmNxtP0+GG+81oyDVj2WDlJn1VivVTEws5yVw=;
        b=qNHQj3/T/awam9NiNDjVEeywQlJP6YY+uUe+yBVILPFn5TiYhEqJ9M/zcIq4Es1ZzD
         cfqEy3f5FCqr2+wJZvQlgIxWcywEiMg093S26HIn6xn3WDts1qbBlKRbWDEadTpK4wE5
         9dTOao7915xjtjVAED7vDJBepEY6KJ0Xc27HS9Xs0vtay1761g2kwGMLPR4G59jcLDti
         ODbc93r3U+NGtbHlHUk9OfRF5lvzhsPGwV11G64Iu3mSAPrqre2uQ14fHy+Z0EMwxAbl
         cbi9DDTqXkSsl9XCwrZ/swVCzla0mWRp+tYp6kWj9PYsSR52Kk97xjBH27mccecP34Ng
         rnWA==
X-Received: by 10.70.38.138 with SMTP id g10mr41265696pdk.98.1430311835851;
        Wed, 29 Apr 2015 05:50:35 -0700 (PDT)
Received: from [172.16.0.91] ([182.48.234.2])
        by mx.google.com with ESMTPSA id uf7sm3963756pab.37.2015.04.29.05.50.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2015 05:50:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267960>

The last iteration of the patch can be seen :
http://thread.gmane.org/gmane.comp.version-control.git/267213

Changes since last version:

sha1_file:
* eliminate "struct strbuf typename = STRBUF_INIT" in 
"parse_sha1_header_extended()"
* make "unpack_sha1_header_to_strbuf()" work automagically. Now it 
unpacks first 32 bytes and checks if the header is unpacked before 
moving to a strbuf.
* remove unnecessary if condition for "strbuf_release()" .

cat-file:
* change the option name from "--literally" to "--allow-unkown-type".
* make the options mutually exclusive.
* clean up '-s' option.

t1006:
* use echo_without_newline() and added quotes.
