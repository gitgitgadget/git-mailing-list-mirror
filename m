From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC] git cat-file "literally" option
Date: Wed, 18 Feb 2015 20:58:01 +0700
Message-ID: <CACsJy8BJnHTyXhhJaCuZAzjm=Gd96EjANEw76j=3L92cmbX7HA@mail.gmail.com>
References: <54E45DD7.205@gmail.com> <54E48A96.8010301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 14:58:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO59B-000523-I4
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 14:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbbBRN6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 08:58:33 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:36800 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbbBRN6c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 08:58:32 -0500
Received: by ierx19 with SMTP id x19so1371762ier.3
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 05:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BpKe7BfrhNNziU8Pb5aUudKTuj7TX5YpKmFL23IH5I0=;
        b=WNqUPV/fxnIMRxDR6dWcj2H3rcKglx99Rb0KKcj4zQQOQ9QkogUrQKSkCnUWoWZ8sk
         EWccFwXXAKP6mw6Q8f7xX9urGn4u/qyPxrQurW9IMgeefNo5Ubb/eIwZo1B9LQx2zYOK
         zZUI9N/Lu1ocqXYfmsvL94VNDuQRBRwUMvaopAC9bnusblvp8W/NVZmkS2aGVK0u3bcJ
         mDGKWbflnNyiLz2OLkamdMPulU+tDJcCSMTKA4YQx7sAAt6Z6/lmx367M9Z6xbjr9EZ8
         40v8k4Cr17XYjTsXzRErajFmAQAWZ6zZqf0Eka5O6jY0E2e2EEMl9fqOvkIlOuYGvd0i
         Dygw==
X-Received: by 10.50.118.97 with SMTP id kl1mr277540igb.23.1424267912111; Wed,
 18 Feb 2015 05:58:32 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Wed, 18 Feb 2015 05:58:01 -0800 (PST)
In-Reply-To: <54E48A96.8010301@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264017>

On Wed, Feb 18, 2015 at 7:50 PM, karthik nayak <karthik.188@gmail.com> wrote:
> Also,
> Is there any way I can get the type of object made via git hash-object
> --literally. The problem I'm facing is "sha1_object_info()" returns a
> object_type enum, so objects not specified there are considered as errors.

Use what sha1_object_info() uses behind the scene. Loose object
encodes object type as a string, you could just print that string and
skip the enum object_type conversion. You probably need special
treatment for packed objects too. See parse_sha1_header() and
unpack_object_header().
-- 
Duy
