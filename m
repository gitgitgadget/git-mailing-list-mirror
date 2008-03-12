From: "Whit Armstrong" <armstrong.whit@gmail.com>
Subject: git latest master: a6828f536119c3288b0be772e3870f1a464d017d -- error in t0050-filesystem.sh on Solaris
Date: Wed, 12 Mar 2008 09:49:25 -0400
Message-ID: <8ec76080803120649h587b1933x6ec513d4b51a29a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 14:50:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZRLQ-0004U7-6q
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 14:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbYCLNt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 09:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbYCLNt2
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 09:49:28 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:44979 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbYCLNt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 09:49:27 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3138077wxd.4
        for <git@vger.kernel.org>; Wed, 12 Mar 2008 06:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=EcBlxRjwt6p2ZAjNMPWmiELGksLtxB9jLnEbTxHz5+A=;
        b=pzqmsRTDw8Aa9lsHWm/R1JRIqz+PshgyR3mY1rQhuAn6w7feWTk/467gqonTL6E/gBqD+bruMrWvXP26nbEhLofvJWVgo2tXXN5l92XLHpEGaYbLY9YqhuuCKo+ngjLCSTJtluNizcdYWfiThVszQP5ojFoUGmXoQmEWeQ35/pY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=N9w/t+2CFSSaJ3OjLObLFASFeh7sqk1T+EqjRMNdkRQzNdzh5BBhEEPU9aMlBxf+2nIVrdlNvoYAHGZlhRCRFR0YAkZtAsLVXY5h1XAYOm1MoVRDR36xpE/m4p5NhjshK6k9sjdAHvOAmfSGKluQP4Mwtue4TH+RSJiFTeBF/Gg=
Received: by 10.140.142.4 with SMTP id p4mr5070126rvd.261.1205329765021;
        Wed, 12 Mar 2008 06:49:25 -0700 (PDT)
Received: by 10.141.201.19 with HTTP; Wed, 12 Mar 2008 06:49:25 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76950>

xs5-trd-p1.grn:warmstro> uname -a
SunOS xs5-trd-p1.grn.tudor.com 5.9 Generic_118558-38 sun4u sparc
SUNW,Sun-Fire-V240 Solaris

the Unrecognized switch: -O is from the perl call:

++ perl -CO -e 'print pack("U",0x00E4)'
Unrecognized switch: -O  (-h will show valid options).
+ auml=
++ perl -CO -e 'print pack("U",0x0061).pack("U",0x0308)'
Unrecognized switch: -O  (-h will show valid options).
+ aumlcdiar=


here is the output log:

xs5-trd-p1.grn:warmstro> bash  t0050-filesystem.sh -v -i
Unrecognized switch: -O  (-h will show valid options).
Unrecognized switch: -O  (-h will show valid options).
* expecting success:

        test_case=test_expect_success
        test_unicode=test_expect_success
        mkdir junk &&
        echo good >junk/CamelCase &&
        echo bad >junk/camelcase &&
        if test "$(cat junk/CamelCase)" != good
        then
                test_case=test_expect_failure
                say "will test on a case insensitive filesystem"
        fi &&
        rm -fr junk &&
        mkdir junk &&
        >junk/"$auml" &&
        case "$(cd junk && echo *)" in
        "$aumlcdiar")
                test_unicode=test_expect_failure
                say "will test on a unicode corrupting filesystem"
                ;;
        *)      ;;
        esac &&
        rm -fr junk

t0050-filesystem.sh: junk/: Is a directory
* FAIL 1: see if we expect


                test_case=test_expect_success
                test_unicode=test_expect_success
                mkdir junk &&
                echo good >junk/CamelCase &&
                echo bad >junk/camelcase &&
                if test "$(cat junk/CamelCase)" != good
                then
                        test_case=test_expect_failure
                        say "will test on a case insensitive filesystem"
                fi &&
                rm -fr junk &&
                mkdir junk &&
                >junk/"$auml" &&
                case "$(cd junk && echo *)" in
                "$aumlcdiar")
                        test_unicode=test_expect_failure
                        say "will test on a unicode corrupting filesystem"
                        ;;
                *)      ;;
                esac &&
                rm -fr junk

xs5-trd-p1.grn:warmstro>


and the main make test log:

*** t0050-filesystem.sh ***
Unrecognized switch: -O  (-h will show valid options).
Unrecognized switch: -O  (-h will show valid options).
* FAIL 1: see if we expect


                test_case=test_expect_success
                test_unicode=test_expect_success
                mkdir junk &&
                echo good >junk/CamelCase &&
                echo bad >junk/camelcase &&
                if test "$(cat junk/CamelCase)" != good
                then
                        test_case=test_expect_failure
                        say "will test on a case insensitive filesystem"
                fi &&
                rm -fr junk &&
                mkdir junk &&
                >junk/"$auml" &&
                case "$(cd junk && echo *)" in
                "$aumlcdiar")
                        test_unicode=test_expect_failure
                        say "will test on a unicode corrupting filesystem"
                        ;;
                *)      ;;
                esac &&
                rm -fr junk

*   ok 2: setup case tests
*   ok 3: rename (case change)
*   ok 4: merge (case change)
* FAIL 5: setup unicode normalization tests


          test_create_repo unicode &&
          cd unicode &&
          touch "$aumlcdiar" &&
          git add "$aumlcdiar" &&
          git commit -m initial
          git tag initial &&
          git checkout -b topic &&
          git mv $aumlcdiar tmp &&
          git mv tmp "$auml" &&
          git commit -m rename &&
          git checkout -f master


* FAIL 6: rename (silent unicode normalization)


         git mv "$aumlcdiar" "$auml" &&
         git commit -m rename


* FAIL 7: merge (silent unicode normalization)


         git reset --hard initial &&
         git merge topic


* failed 4 among 7 test(s)
gmake[1]: *** [t0050-filesystem.sh] Error 1
gmake[1]: Leaving directory `/home/warmstro/dvl.whit/git/t'
gmake: *** [test] Error 2
