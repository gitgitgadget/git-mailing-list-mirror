From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Windows performance / threading file access
Date: Fri, 11 Oct 2013 12:48:01 +0700
Message-ID: <CACsJy8Db6Mg+Zg+E6qRLfsDyWsQcxGLV=RR=-XGHK1Wi6XpAzQ@mail.gmail.com>
References: <CAHOQ7J_ZZ=7j-5ULd7Tdvbiqg4inhwi+fue_w6WAtNRkvZSwsg@mail.gmail.com>
 <52570BC1.2040208@gmail.com> <52574B90.3070309@gmail.com> <CAHOQ7J_sNnajm9M+QUd-QwkQGP2vOidzAW5_5EzsdwBGTDCnSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>, Sebastian Schuberth <sschuberth@gmail.com>, 
	Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Stefan Zager <szager@google.com>
X-From: msysgit+bncBC2ZN5PHQUMBBL5C32JAKGQELZUOAHY@googlegroups.com Fri Oct 11 07:48:33 2013
Return-path: <msysgit+bncBC2ZN5PHQUMBBL5C32JAKGQELZUOAHY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f187.google.com ([209.85.220.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBBL5C32JAKGQELZUOAHY@googlegroups.com>)
	id 1VUVaS-0006vj-Tx
	for gcvm-msysgit@m.gmane.org; Fri, 11 Oct 2013 07:48:33 +0200
Received: by mail-vc0-f187.google.com with SMTP id id10sf434899vcb.4
        for <gcvm-msysgit@m.gmane.org>; Thu, 10 Oct 2013 22:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=rxH5C/j7nAwSJ6iF2wzXtNwE3iGMEoZZTdbfqA2olPs=;
        b=Oz69h5vI0Z2gibRV7gjHA3vW06LiU7L+dMbPu2VDD0nBrtVDugnxmCJdYL0QY2F8Om
         8nyaQTcQLplb60QzgbjZbHy4ubK3Hf+B4fPHJoiHuxLSyuXlw0dcbOAirt7rHjG5gx9R
         ec+EMRJWF0IbtxjxpmkkFg2Es78bvH6zB7pfUleGxsSgSr61f4iJmlJ1uapBLdAJmbPT
         1a496qrZhuKcXbFaE/AMVkE4lEJqOfV3juJCROkXTeRVxkXAzdnTk1ogNel3p9ymApzQ
         kzAdi5P/k8Qg5rLfyHXAizQhWfWvDQgAlIzELHJ+5XMP7D55VMOyV8NZtCcd8jRVg46y
         oUHA==
X-Received: by 10.49.104.83 with SMTP id gc19mr129429qeb.12.1381470512087;
        Thu, 10 Oct 2013 22:48:32 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.74.69 with SMTP id r5ls1250648qev.1.gmail; Thu, 10 Oct 2013
 22:48:31 -0700 (PDT)
X-Received: by 10.236.186.101 with SMTP id v65mr17046724yhm.12.1381470511472;
        Thu, 10 Oct 2013 22:48:31 -0700 (PDT)
Received: from mail-oa0-x22c.google.com (mail-oa0-x22c.google.com [2607:f8b0:4003:c02::22c])
        by gmr-mx.google.com with ESMTPS id e4si218691igy.1.2013.10.10.22.48.31
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 22:48:31 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:4003:c02::22c as permitted sender) client-ip=2607:f8b0:4003:c02::22c;
Received: by mail-oa0-f44.google.com with SMTP id l20so1763483oag.3
        for <msysgit@googlegroups.com>; Thu, 10 Oct 2013 22:48:31 -0700 (PDT)
X-Received: by 10.60.103.37 with SMTP id ft5mr434658oeb.45.1381470511228; Thu,
 10 Oct 2013 22:48:31 -0700 (PDT)
Received: by 10.76.0.41 with HTTP; Thu, 10 Oct 2013 22:48:01 -0700 (PDT)
In-Reply-To: <CAHOQ7J_sNnajm9M+QUd-QwkQGP2vOidzAW5_5EzsdwBGTDCnSA@mail.gmail.com>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:4003:c02::22c
 as permitted sender) smtp.mail=pclouds@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235894>

On Fri, Oct 11, 2013 at 12:35 PM, Stefan Zager <szager@google.com> wrote:
> For my test, I first run 'git clone -n <repo>', and then measure the
> running time of 'git checkout --force HEAD'.  On linux, the checkout
> command runs in 0:12; on Windows, it's about 3:30.

try

git read-tree HEAD
git ls-files | xargs -P=XXX -n=YYYY git checkout-index

That should give you a rough idea how much gain (or loss) by parallelization
-- 
Duy

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
