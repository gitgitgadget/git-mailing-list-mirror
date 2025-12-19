Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFBD32D7F4
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766155842; cv=none; b=kTNjrJZI6KrXyUbYD//3WDYDhM+ij2e0CcH9SmW5GosVT8uOKH1seugPZNE5aRI4UD6SYExpUVHXhuxx0g7/BKEtOECErf5NqbnckVrbK6dUuxX0LBCezj8IkvQSRGW+AH500+Nn6AkJWeYq0xbvbxwuZQvXKgOs+RiQ7W2LzkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766155842; c=relaxed/simple;
	bh=WAlBdFPOiZL18zsr6gbxE5AlxYfDqH6/0B0FBT2iMKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hH+cBJw36+nXD3ho/QzDM+A989p7qb4DqpBTBnejyNO6bZb6xJLotphOOzk4aCVmDpFkqJ/WgPgIaFTJB6JkiBAUl6J80i2VqFG04Ka4FH9WPT17mCYfYjgN9hDTdDLBbWJTgja8Q8wj2HxvYxvfnv77lvdVIWSFZVLZ5GzrBhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtZ9ND+G; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtZ9ND+G"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5958931c9c7so2140649e87.2
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 06:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766155839; x=1766760639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7jVc7X1NDg4yLJcyqel+EtF1qmS+HZHD6U7uMP/eKE=;
        b=QtZ9ND+GBVjcRXeQ1g6U2sqbVNL9ExrF7MJ1DeVIQtGI3e8FTztHJNUq+k42w8fUdY
         SmiU2U9NKIs+pWCjWK6I01sZWct0mCslz2u2otC00EsrHRROZKFt2k5xg7Vrpu+jP5GQ
         D5ycKWfJ9DRnvZIAnFrD6gVKjcn3wfjCFXW8dT81gxWmFvWtHG+6FQ5vnTOPjBO6zNSK
         nqd3XsfCFW/wrkaOnxKqwPRWhnXwm/rwBRsKCNyS7PuryWkf3rfzbymy0805i/XhoyA7
         JHe8iw+S68kYgGqdE1/otRrIUTZljr3XTVuqqXfbC5wzmDNrMpU5LC1mU3DdUR+YLqnA
         ClYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766155839; x=1766760639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y7jVc7X1NDg4yLJcyqel+EtF1qmS+HZHD6U7uMP/eKE=;
        b=ZSiMtKLP9LZFdwLOBRidIlyOGccGHBFIx/yvXkax7ag9NHV94jtXx447tft/N+ohqm
         oAzlzVrmTJ3jIITkHhAWRjNolK7TVUizbYvkvpmZiYWMEDOwCqMNsJP1AnG+pQm/z6kZ
         aACy8kYSL1hYvEtS434H7xA/C13U8h0bWr0tCN7nTZWzwxubZCBw2EzfMQsZ0YWx/O87
         VsvnXCHzkPVvC3Ny7wFUUus+NeCfXxucSMVvVQrKq3tLoJUVMIukr03YMjs1VfDa09qJ
         nLLFx70ivwInSOlD2Rfva4XbPzQI11mkXWD+JX8PjBU7HnLReO10VLj5Vx3j7kwYQJmt
         2pBg==
X-Forwarded-Encrypted: i=1; AJvYcCWz5/mR2/W8mo/W/rm9BDaACk1pX+97+SyG6mGH6TdIGWN7kZ5PEOPKWaDWrgUTILrOY6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdsT5kfb7FU0398VKJJI5doKZNeN5Dhl7KtNxul/MWIiJkT8vX
	7kR6pd9ROnsRvn3v8rUM32Y08WF0dVDrieDog6M2Gj/QypE8GinkvY9Z8mySmA==
X-Gm-Gg: AY/fxX6VNPKq+JrEq9utt/Ccp4GjSiuD9a6hlnsqViX5EFML3PvV7Ge2qx6C3rK92sW
	JqlJ9mb3moT20N77ghPWxf4ocUVDeTpAXqqqX78ftnoB9bL3K0w+o7OlwC0T01rBhuYmGT5DzC6
	hkeCkIyenW2kV1LlCp+imaBVt7jvkrioiiRyz3rZwhnIRhHvPiwiBc8FIRFgppN0rAyNbhAKgAo
	KcdsBz1Pm/JDdU/z6TwPVyGxKPB3E7jTykKVd69HjyPm/s0P0/7CQFxkFF1ziqvaXegD5lIVo6W
	5sej58uyCkVL6dT5JnnIHWExWHv07zNLkjd1xG8VoIqpkIYgMig33SeINq+Ji2j6qepnKtt5+Rr
	gDlzNu4PQLbYkEXaFCY+UvxZ+5Bxdwf/zPNuVZSS5x/l0dfIzr8dQpp3aiJS4ZfYd/W/c+Gt3Su
	RtGaShvrxdhx1FcCpQwj+eGF2vf/S5Ox73Yh9rmarCZfxI4Ibop+SsJKcVIBABUk0PoBFcxc4=
X-Google-Smtp-Source: AGHT+IGKB4BjoH9C7zHAYk1lGtRtoMxlyL5XJRJgNA5GO8OeumuH2taLUWJQ3dRrmkFRf1xeXtB+8Q==
X-Received: by 2002:a05:6512:124d:b0:59a:115f:5b82 with SMTP id 2adb3069b0e04-59a17de2749mr1281721e87.24.1766155838832;
        Fri, 19 Dec 2025 06:50:38 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185ddb06sm760857e87.33.2025.12.19.06.50.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Dec 2025 06:50:38 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: collin.funk1@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] diff: add --no-indicators option
Date: Fri, 19 Dec 2025 15:50:37 +0100
Message-Id: <20251219145037.17880-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <f141e335-9729-4f09-86b2-12a39f24837a@gmail.com>
References: <f141e335-9729-4f09-86b2-12a39f24837a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Collin!

The use case for me is when working on a feature and digging through my own
commits to recover a code block that I previously threw away. Then I dont't
want to do 'git restore -p' and go through all the changes in that file.

I just want to quickly pick out the thing I need, that could be e.g. this
snippet

```
            top={
              spcGoalMarkerPositionStaticProps.y -
              ARROW_SIZE / 2 +
              ARROW_OUTWARD_OFFSET * Math.sin(arrowAngleRadians)
            }
            left={
              spcGoalMarkerPositionStaticProps.x -
              ARROW_SIZE / 2 +
              ARROW_OUTWARD_OFFSET * Math.cos(arrowAngleRadians)
            }
```

from the full diff below:

```
--- a/src/ui/components/SatietyIndicator.tsx
+++ b/src/ui/components/SatietyIndicator.tsx

   const spcGoalCompletionOuterGAnimProps = useAnimatedProps(() => {
     return {
-      opacity: satietyGoalScore
+      opacity: shouldShowGoalMarker
         ? interpolate(spcGoalMarkerOpacitySV.value, [0, 1], [1, 0])
         : 0,
     }
@@ -364,7 +372,7 @@ export const SatietyIndicator: FC<Props> = ({

     const centerAdjustment = -(CHECKMARK_SIZE * scale) / 2

-    return satietyGoalScore
+    return shouldShowGoalMarker
       ? {
           transform: [
             {scale: scale},
@@ -383,11 +391,19 @@ export const SatietyIndicator: FC<Props> = ({
         {shouldShowReachHere && (
           <AnimatedBox
             position={'absolute'}
-            top={spcGoalMarkerPositionStaticProps.y - 18}
-            left={spcGoalMarkerPositionStaticProps.x - 9}
+            top={
+              spcGoalMarkerPositionStaticProps.y -
+              ARROW_SIZE / 2 +
+              ARROW_OUTWARD_OFFSET * Math.sin(arrowAngleRadians)
+            }
+            left={
+              spcGoalMarkerPositionStaticProps.x -
+              ARROW_SIZE / 2 +
+              ARROW_OUTWARD_OFFSET * Math.cos(arrowAngleRadians)
+            }
             style={arrowBounceStyle}>
             <PointerArrow
-              size={18}
+              size={ARROW_SIZE}
               color={'black'}
               angle={270 + arrowTiltDegrees}
             />
```

I do this already, it just has the extra step of having to go through
manually and remove +/- characters. Since already have the red and green
colors to judge me, +/- doesn't help anything.

I would also like to add this to 'git show'

Harald
